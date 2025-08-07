//
//  BMIViewController.swift
//  MVVMBasic
//
//  Created by Finn on 8/7/25.
//

import UIKit

enum InfoType: String {
    case height = "키"
    case weight = "몸무게"
}

class BMIViewController: UIViewController {
    
    var height: Double?
    var weight: Double?
    
    let heightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "키를 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let weightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "몸무게를 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let resultButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("클릭", for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "여기에 결과를 보여주세요"
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        
        resultButton.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
    }
    
    func configureHierarchy() {
        view.addSubview(heightTextField)
        view.addSubview(weightTextField)
        view.addSubview(resultButton)
        view.addSubview(resultLabel)
    }
    
    func configureLayout() {
        heightTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        weightTextField.snp.makeConstraints { make in
            make.top.equalTo(heightTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(weightTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resultLabel.snp.makeConstraints { make in
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
        
        height = nil
        weight = nil
        
        setHeightValue()
        guard let height = height else { return }
        
        setWeightValue()
        guard let weight = weight else { return }
        
        resultLabel.text = "BMI: \(String(calculateBMI(height: height, weight: weight)))"
    }
    
    func calculateBMI(height: Double, weight: Double) -> Double {
        let heightMeter = height * 0.01
        let bmi = weight / ( heightMeter * heightMeter )
        return Double(Int(bmi * 100) / 100)
    }
    
    func setHeightValue() {
        guard let text = heightTextField.text else { return }
        let result = checkIsValiDouble(text: text, type: InfoType.height)
        let isDouble = result.0
        let height = result.1
        
        if isDouble {
            self.height = checkIsValidRangeAndReturn(value: height, min: 100.0, max: 200.0, type: InfoType.height)
        }
    }
    
    func setWeightValue() {
        guard let text = weightTextField.text else { return }
        let result = checkIsValiDouble(text: text, type: InfoType.weight)
        let isDouble = result.0
        let weight = result.1
        
        if isDouble {
            self.weight = checkIsValidRangeAndReturn(value: weight, min: 30.0, max: 150.0, type: InfoType.weight)
        }
    }
    
    func checkIsValiDouble(text: String, type: InfoType) -> (Bool, Double) {
        do {
            let value = try ErrorManager.shared.validateUserInput(text: text, transferType: Double.self)
            return (true, value)
        } catch {
            switch error {
            case .EmptyString:    makeAlert(message: "\(type.rawValue) 값이 비어 있습니다")
            case .haveWhiteSpace: makeAlert(message: "\(type.rawValue) 값에 띄어쓰기를 포함할 수 없습니다")
            case .isNotDouble:    makeAlert(message: "입력한 \(type.rawValue) 값이 double이 아닙니다")
            default:              makeAlert(message: "입력한 \(type.rawValue) 값이 올바른 타입이 아닙니다")
            }
            return (false, 0)
        }
    }
    
    func checkIsValidRangeAndReturn(value: Double, min: Double, max: Double, type: InfoType) -> Double? {
        do {
            try ErrorManager.shared.validateNumberRange(value: value, min: min, max: max)
            return value
        } catch {
            switch error {
            case .lowerTHanMinimum: 
                switch type {
                case .height: makeAlert(message: "키는 \(min)cm 이상으로 입력해주세요!")
                case .weight: makeAlert(message: "몸무게는 \(min)kg 이상으로 입력해주세요!")
                }
            case .upperTHanMaximum:
                switch type {
                case .height: makeAlert(message: "키는 \(min)cm 이하로 입력해주세요!")
                case .weight: makeAlert(message: "몸무게는 \(min)kg 이하로 입력해주세요!")
                }
            }
            return nil
        }
    }
}
