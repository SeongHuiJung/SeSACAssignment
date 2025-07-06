//
//  BMIViewController.swift
//  SeSAC7Week1Remind
//
//  Created by 정성희 on 7/4/25.
//

import UIKit

class BMIViewController: UIViewController {

    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var heightQuestionLabel: UILabel!
    @IBOutlet var weightQuestionLabel: UILabel!
    
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    
    @IBOutlet var hideWeightButton: UIButton!
    @IBOutlet var executeButton: UIButton!
    @IBOutlet var randomButton: UIButton!
    
    @IBOutlet var heightHintLabel: UILabel!
    @IBOutlet var weightHintLabel: UILabel!
    
    @IBOutlet var resultLabel: UILabel!
    
    var isBMIInputValid = false {
        didSet {
            if isBMIInputValid {
                executeButton.backgroundColor = .purple
                executeButton.setTitleColor(.white, for: .normal)
            }
            else {
                executeButton.backgroundColor = .lightGray
                executeButton.setTitleColor(.white, for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLabelUI()
        setTextFieldUI()
        setButtonUI()
        isBMIInputValid = false
    }

    
    // MARK: - Action
    
    @IBAction func executeButtonTapped(_ sender: UIButton) {
        if isBMIInputValid {
            let height = Int(heightTextField.text!)!
            let weight = Int(weightTextField.text!)!
            
            let bmi = calculateBMI(height: Double(height), weight: Double(weight))
            
            let formatter = NumberFormatter()
            formatter.maximumFractionDigits = 1
            formatter.minimumFractionDigits = 1
            formatter.numberStyle = .decimal

            if let formattedBmi = formatter.string(from: NSNumber(value: bmi)) {
                resultLabel.text = formattedBmi
            }
        }
        else {
            resultLabel.text = "올바른 값을 먼저 입력해주세요"
        }
    }
    func calculateBMI(height: Double, weight: Double) -> Double {
        let meterHeight = height / 100
        return weight / (meterHeight * meterHeight)
    }
    

    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        guard !checkIsEmpty(sender: sender, hintLabel: heightHintLabel) else {
            isBMIInputValid = false
            return
        }
        guard checkIsNumber(sender: sender, hintLabel: heightHintLabel) else {
            isBMIInputValid = false
            return
        }
        guard checkNumberRange(sender: sender, hintLabel: heightHintLabel, minValue: 100, maxValue: 200) else {
            isBMIInputValid = false
            return
        }
        
        isBMIInputValid = checkIsBMIInputValid()
    }
    @IBAction func weightextFieldEditingChanged(_ sender: UITextField) {
        guard !checkIsEmpty(sender: sender, hintLabel: weightHintLabel) else {
            isBMIInputValid = false
            return
        }
        
        guard checkIsNumber(sender: sender, hintLabel: weightHintLabel) else {
            isBMIInputValid = false
            return
        }
        guard checkNumberRange(sender: sender, hintLabel: weightHintLabel, minValue: 20, maxValue: 120) else {
            isBMIInputValid = false
            return
        }
        
        isBMIInputValid = checkIsBMIInputValid()
    }
    
    func checkIsEmpty(sender: UITextField, hintLabel: UILabel) -> Bool {
        if sender.text == "" {
            hintLabel.text = ""
            return true
        }
        return false
    }
    func checkIsNumber(sender: UITextField, hintLabel: UILabel) -> Bool {
        guard Int(sender.text!) != nil else {
            hintLabel.text = "숫자만 입력해주세요"
            return false
        }
        hintLabel.text = ""
        return true
    }
    func checkNumberRange(sender: UITextField, hintLabel: UILabel, minValue: Int, maxValue: Int) -> Bool {
        let value = Int(sender.text!)!
        if value < minValue {
            hintLabel.text = "\(minValue) 이상 입력해주세요"
            return false
        }
        else if value > maxValue {
            hintLabel.text = "\(maxValue) 이하로 입력해주세요"
            return false
        }
        else { return true }
    }
    func checkIsBMIInputValid() -> Bool {
        guard heightTextField.text != "" && weightTextField.text != "" else {
            return false
        }
        return true
    }
    
    @IBAction func hideWeightButtonTapped(_ sender: UIButton) {
        weightTextField.isSecureTextEntry = !weightTextField.isSecureTextEntry
    }
    @IBAction func randomButtonTapped(_ sender: UIButton) {
        let height = Int.random(in: 100...200)
        let weight = Int.random(in: 20...120)
        
        heightTextField.text = String(height)
        weightTextField.text = String(weight)
        
        isBMIInputValid = checkIsBMIInputValid()
    }
    
    
    // MARK: - UI
    func setLabelUI() {
        detailLabel.text = """
            당신의 BMI 지수를
            알려드릴게요.
            """
        detailLabel.font = .systemFont(ofSize: 15)
        detailLabel.textColor = .black
        detailLabel.textAlignment = .left
        detailLabel.backgroundColor = .clear
        
        heightQuestionLabel.text = "키가 어떻게 되시나요?"
        heightQuestionLabel.font = .systemFont(ofSize: 15)
        heightQuestionLabel.textColor = .black
        heightQuestionLabel.textAlignment = .left
        heightQuestionLabel.backgroundColor = .clear
        
        weightQuestionLabel.text = "몸무게가 어떻게 되시나요?"
        weightQuestionLabel.font = .systemFont(ofSize: 15)
        weightQuestionLabel.textColor = .black
        weightQuestionLabel.textAlignment = .left
        weightQuestionLabel.backgroundColor = .clear

        hideWeightButton.tintColor = .gray
        
        heightHintLabel.text = ""
        heightHintLabel.font = .systemFont(ofSize: 12)
        heightHintLabel.textColor = .red
        heightHintLabel.textAlignment = .left
        
        weightHintLabel.text = ""
        weightHintLabel.font = .systemFont(ofSize: 12)
        weightHintLabel.textColor = .red
        weightHintLabel.textAlignment = .left
        
        resultLabel.text = ""
        resultLabel.font = .systemFont(ofSize: 15)
        resultLabel.textColor = .black
        resultLabel.textAlignment = .center
    }
    func setTextFieldUI() {
        heightTextField.attributedPlaceholder = NSAttributedString(string: "키를 입력해 주세요", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        heightTextField.backgroundColor = .white
        heightTextField.font = .systemFont(ofSize: 15)
        heightTextField.textColor = .black
        
        heightTextField.layer.borderWidth = 1
        heightTextField.layer.borderColor = UIColor.black.cgColor
        
        heightTextField.layer.cornerRadius = 12
        heightTextField.clipsToBounds = true
        
        // 입력하는 부분 왼쪽에 간격 추가
        heightTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 0.0))
        heightTextField.leftViewMode = .always
        
        weightTextField.attributedPlaceholder = NSAttributedString(string: "몸무게를 입력해 주세요", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        weightTextField.backgroundColor = .white
        weightTextField.font = .systemFont(ofSize: 15)
        weightTextField.textColor = .black
        
        weightTextField.layer.borderWidth = 1
        weightTextField.layer.borderColor = UIColor.black.cgColor
        
        weightTextField.layer.cornerRadius = 12
        weightTextField.clipsToBounds = true
        
        // 입력하는 부분 왼쪽에 간격 추가
        weightTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 0.0))
        weightTextField.leftViewMode = .always
    }
    func setButtonUI() {
        executeButton.setTitle("결과 확인", for: .normal)
        executeButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        executeButton.setTitleColor(.white, for: .normal)
        executeButton.backgroundColor = .purple
        executeButton.layer.cornerRadius = 15
        executeButton.clipsToBounds = true
        
        randomButton.setTitle("랜덤으로 BMI 계산하기", for: .normal)
        randomButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        randomButton.setTitleColor(.red, for: .normal)
        randomButton.backgroundColor = .clear
    }
}
