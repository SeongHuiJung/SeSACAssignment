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

    let viewModel = NumberViewModel()
    
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
        
        let input = NumberViewModel.Input(
            valueChaged: Observable.combineLatest(
            number1.rx.text.orEmpty,
            number2.rx.text.orEmpty,
            number3.rx.text.orEmpty)
        )
        let output = viewModel.transform(input: input)
        
        output.resultValue
            .bind(with: self) { owner, result in
                owner.resultLabel.text = result
            }
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
