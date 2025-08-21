//
//  SimpleValidationViewMode.swift
//  RxSwiftStudy
//
//  Created by 정성희 on 8/21/25.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class SimpleValidationViewModel {
    struct Input {
        let usernameChanged: ControlProperty<String>
        let passwordChanged: ControlProperty<String>
        let actionButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let usernameValid: BehaviorRelay<Bool>
        let passwordValid: BehaviorRelay<Bool>
        let everythingValid: BehaviorRelay<CustomColor>
        let usernameHintText: BehaviorRelay<String>
        let passwordHintText: BehaviorRelay<String>
        let actionButtonTapped: BehaviorRelay<()>
    }
    
    private let minimalUsernameLength = 5
    private let minimalPasswordLength = 5
    
    private let disposeBag = DisposeBag()
    
    init() {}
    
    func transform(input: Input) -> Output {
        
        let usernameValid = BehaviorRelay(value: false)
        let passwordValid = BehaviorRelay(value: false)
        let everythingValid = BehaviorRelay(value: CustomColor.deactive)
        let usernameHintText = BehaviorRelay(value: "")
        let passwordHintText = BehaviorRelay(value: "")
        let actionButtonTapped = BehaviorRelay(value: ())
        
        input.usernameChanged
            .withUnretained(self)
            .map { owner, value in
                value.count >= owner.minimalUsernameLength }
            .share(replay: 1)
            .bind(with: self) { owner, isValid in
                usernameValid.accept(isValid)
            }
            .disposed(by: disposeBag)
        
        input.passwordChanged
            .withUnretained(self)
            .map { owner, value in
                value.count >= owner.minimalPasswordLength }
            .share(replay: 1)
            .bind(with: self) { owner, isValid in
                passwordValid.accept(isValid)
            }
            .disposed(by: disposeBag)
        
        Observable.combineLatest(usernameValid, passwordValid)
            .map { (username, password) in
                return username && password
            }
            .bind(with: self) { owner, isTrue in
                isTrue ? everythingValid.accept(CustomColor.active): everythingValid.accept(CustomColor.deactive)
            }
            .disposed(by: disposeBag)
        
        // 화면에 들어가자마자 실행되고 있음
        // TODO: lazyBind 처럼 탭 했을때만 실행되게 하려면?
        input.actionButtonTapped
            .bind(with: self) { owner, _ in
                actionButtonTapped.accept(())
            }
            .disposed(by: disposeBag)
        
        usernameHintText.accept("이름은 \(minimalUsernameLength)글자 이상 입력해주세요")
        passwordHintText.accept("비밀번호는 \(minimalPasswordLength)글자 이상 입력해주세요")
            
        return Output(usernameValid: usernameValid, passwordValid: passwordValid, everythingValid: everythingValid, usernameHintText: usernameHintText, passwordHintText: passwordHintText, actionButtonTapped: actionButtonTapped)
    }
}

enum CustomColor {
    case active
    case deactive
    
    var color: UIColor {
            switch self {
            case .active:
                return .systemBlue
            case .deactive:
                return .lightGray
            }
        }
}
