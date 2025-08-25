//
//  SetNameViewModel.swift
//  TamagotchiGame
//
//  Created by 정성희 on 8/24/25.
//

import Foundation
import RxSwift
import RxCocoa

class SetNameViewModel {
    struct Input {
        let saveButtonTapped: ControlEvent<()>
        let name: ControlProperty<String>
    }
    
    struct Output {
        let nameSetCompleted: PublishRelay<()>
    }
    
    init() {}
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {

        let nameSetCompleted: PublishRelay<()> = PublishRelay()
        
        input.saveButtonTapped
            .withLatestFrom(input.name)
            .filter { name in
                2 <= name.count && name.count <= 6
            }
            .bind(with: self) { owner, name in
                UserDefaultsManager.userName = name
                nameSetCompleted.accept(())
            }
            .disposed(by: disposeBag)
        
        return Output(nameSetCompleted: nameSetCompleted)
    }
}
