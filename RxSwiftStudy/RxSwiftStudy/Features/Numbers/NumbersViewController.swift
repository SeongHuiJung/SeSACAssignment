//
//  NumbersViewController.swift
//  RxSwiftStudy
//
//  Created by 정성희 on 8/19/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class NumbersViewController: UIViewController {

    let number1 = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    let number2 = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    let number3 = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let resultLabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .blue
        return label
    }()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self, #function)
        configure()
        bind()
    }
    
    private func bind() {
        Observable.combineLatest(
            number1.rx.text.orEmpty,
            number2.rx.text.orEmpty,
            number3.rx.text.orEmpty) { textValue1, textValue2, textValue3 -> Int in
                // 갑자기 클로저가 나오는 이유? -> 지지고 볶아서 내가 원하는 값으로 return 할 수 있는 것 같다고 추정..?
                // 이런 목적이 맞다면 어떤 operator 에 대해 사용할 수 있는걸까? 모든 operator 일까?
                // -> combineLatest 이 그런 특성을 갖고 있기 때문
                return (Int(textValue1) ?? 0) + (Int(textValue2) ?? 0) + (Int(textValue3) ?? 0)
            }
            .map { $0.description } // 여기까지 Observable
        
            // 여기부터 Observer
            .bind(to: resultLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func configure() {
        [number1,number2,number3,resultLabel].forEach { view.addSubview($0) }
        number1.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
            make.width.equalTo(200)
        }
        number2.snp.makeConstraints { make in
            make.top.equalTo(number1.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
            make.width.equalTo(200)
        }
        number3.snp.makeConstraints { make in
            make.top.equalTo(number2.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
            make.width.equalTo(200)
        }
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(number3.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
    }
}
