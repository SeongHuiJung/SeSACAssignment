//
//  AgeViewController.swift
//  MVVMBasic
//
//  Created by Finn on 8/7/25.
//

import UIKit

class AgeViewController: UIViewController {
    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "나이를 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let resultButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle( "클릭", for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    let label: UILabel = {
        let label = UILabel()
        label.text = "여기에 결과를 보여주세요"
        label.textAlignment = .center
        return label
    }()
    
    var age = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        
        resultButton.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
    }
    
    func configureHierarchy() {
        view.addSubview(textField)
        view.addSubview(resultButton)
        view.addSubview(label)
    }
    
    func configureLayout() {
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(resultButton.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func resultButtonTapped() {
        view.endEditing(true)
        
        guard let text = textField.text else { return }
        
        if checkIsValidInteger(text: text) {
            checkIsValidRange(age: age)
        }
    }
    
    func checkIsValidInteger(text: String) -> Bool {
        do {
            age = try ErrorManager.shared.validateUserInput(text: text, transferType: Int.self)
            return true
        } catch {
            switch error {
            case .EmptyString: label.text = "값이 비어있습니다"
            case .haveWhiteSpace: label.text = "띄어쓰기를 포함할 수 없습니다"
            case .isNotInt:    label.text = "정수가 아닙니다"
            default:           label.text = "올바른 타입이 아닙니다"
            }
            return false
        }
    }
    
    func checkIsValidRange(age: Int) {
        do {
            try ErrorManager.shared.validateNumberRange(value: age, min: 1, max: 100)
            label.text = "\(age)살 입니다"
        } catch {
            switch error {
            case .lowerTHanMinimum: label.text = "1살 이상의 값을 입력해주세요!"
            case .upperTHanMaximum: label.text = "100살 이하의 값을 입력해주세요!"
            }
        }
    }
}
