//
//  LoginViewController.swift
//  SeSACDay2HW
//
//  Created by 정성희 on 7/1/25.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet var IDTextField: UITextField!
    @IBOutlet var PWTextField: UITextField!
    @IBOutlet var nickNameTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var recommendCodeTextField: UITextField!
    
    @IBOutlet var IDHintLabel: UILabel!
    @IBOutlet var PWHintLabel: UILabel!
    @IBOutlet var PWCountLabel: UILabel!
    @IBOutlet var PWCountLimitLabel: UILabel!
    @IBOutlet var nickNameHintLabel: UILabel!
    @IBOutlet var locationCountLabel: UILabel!
    @IBOutlet var locationCountLimitLabel: UILabel!
    
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var additionalInfoSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFieldUI()
        setHintLabelUI()
        setRegisterButtonUI()
        setSwitchUI()
    }
    
    // MARK: - 유효성 검증
    // 요구사항은 다음과 같습니다.
    // 1. ID 가 이메일이라면 @과 . 를 반드시 포함해야 하며 전화번호라면 11개의 숫자를 입력해야 합니다.
    // 2. 비밀번호가 8자리 이상 15자리 이하여야 합니다
    // 3. 닉네임에 특수문자 ["!", "?", "@", "#", "^"] 가 들어가면 안됩니다
    // 4. 위치 글자수는 50자 이하여야 합니다
    // 5. 상단의 4가지를 모두 만족해야 회원가입이 가능합니다
    
    // ID 유효성 확인
    func checkIDValidation() -> Int {
        // 0: ID가 유효함
        // 1: 전화번호가 유효하지 않은 경우
        // 2: 이메일이 유효하지 않은 경우
        // 3: 아무것도 입력되지 않음
        
        let text = IDTextField.text!
        if text.count == 0 { return 3 }
        
        let regex = "[A-Za-z]+"
        
        // 이메일 입력한 경우
        if let _ = text.range(of: regex, options: .regularExpression) {
            // 이메일 유효하지 않음
            if !text.contains("@") || !text.contains(".") { return 2 }
        }
        
        // 전화번호 입력한 경우
        else {
            // 전화번호가 유효하지 않음
            if text.count != 11 { return 1 }
        }
        
        return 0
    }
    @IBAction func IDTextFieldValueChanged(_ sender: UITextField) {
        switch checkIDValidation() {
        case 0 : IDHintLabel.text = ""
        case 1 : 
            IDHintLabel.text = "올바른 전화번호가 아니에요"
            IDHintLabel.textColor = UIColor(named: "errorHintLabelColor")
        case 2 : 
            IDHintLabel.text = "올바른 이메일이 아니에요"
            IDHintLabel.textColor = UIColor(named: "errorHintLabelColor")
        case 3 : IDHintLabel.text = ""
        default: break
        }
    }
    
    // 비밀번호 글자수 유효성 체크
    @IBAction func checkPWTextFieldValidation(_ sender: UITextField) {
        PWCountLabel.text = String("\(PWTextField.text!.count)")
        
        // 8자 이상 15자 이하 유효성 검증
        let count = PWTextField.text!.count
        if count < 8 || count > 15 {
            PWCountLabel.textColor = UIColor(named: "errorHintLabelColor")
        }
        else {
            PWCountLabel.textColor = .lightGray
        }
    }
    
    // 닉네임에 특수기호가 있는지 확인하는 함수
    func isExistSpecialSymbol() -> Bool{
        let specialSymbolList = ["!", "?", "@", "#", "^"]
        let text = nickNameTextField.text!
        
        for specialSymbol in specialSymbolList {
            if text.contains(specialSymbol) {
                return true
            }
        }
        
        return false
    }
    @IBAction func nickNameTextFieldValueChanged(_ sender: UITextField) {
        if isExistSpecialSymbol() {
            nickNameHintLabel.textColor = UIColor(named: "errorHintLabelColor")
        }
        else {
            nickNameHintLabel.textColor = .lightGray
        }
    }
    
    // 위치 글자수 유효성 체크
    @IBAction func checkLoacationTextFieldValidation(_ sender: UITextField) {
        locationCountLabel.text = String("\(locationTextField.text!.count)")
        
        // 50자 이하 유효성 검증
        let count = locationTextField.text!.count
        if count > 50  {
            locationCountLabel.textColor = UIColor(named: "errorHintLabelColor")
        }
        else {
            locationCountLabel.textColor = .lightGray
        }
    }
    
    // 최종적으로 모든 유효성 검사를 통과하면 true 반환하여 회원가입 성공 안내
    func checkRegisterAble() -> Bool {
        if checkIDValidation() != 0 { return false }
        if PWTextField.text!.count < 8 || PWTextField.text!.count > 15 { return false }
        if isExistSpecialSymbol() || nickNameTextField.text!.count == 0 { return false }
        if locationTextField.text!.count > 50 { return false }
        return true
    }

    // MARK: - 버튼 클릭
    
    // 회원가입 버튼 클릭
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        print("ID: \(IDTextField.text ?? "")")
        print("PW: \(PWTextField.text ?? "")")
        print("nickname: \(nickNameTextField.text ?? "")")
        print("location: \(locationTextField.text ?? "")")
        print("recommendCode: \(recommendCodeTextField.text ?? "")")
        
        if checkRegisterAble() { print("\n회원가입 성공!") }
        else { print("\n회원가입 실패!") }
    }
    
    // 키보드에서 return 클릭시 키보드 내림
    @IBAction func IDTextFieldTapReturn(_ sender: UITextField) {}
    @IBAction func PWTextFieldTapReturn(_ sender: UITextField) {}
    @IBAction func nickNameTextFieldTapReturn(_ sender: UITextField) {}
    @IBAction func locationTextFieldTapReturn(_ sender: UITextField) {}
    @IBAction func recommendCodeTextFieldTapReturn(_ sender: UITextField) {}
    
    // MARK: - UI 설정
    func setHintLabelUI() {
        IDHintLabel.text = "" // 이메일 입력시 @포함 여부 확인. 전화번호 일 경우 아무것도 표기안함
        PWHintLabel.text = "8자 이상 15자 이하로 입력해 주세요"
        nickNameHintLabel.text = "특수기호는 포함할 수 없습니다"
        PWCountLabel.text = "0"
        
        IDHintLabel.textColor = .lightGray
        PWHintLabel.textColor = .lightGray
        PWCountLabel.textColor = UIColor(named: "errorHintLabelColor")
        PWCountLimitLabel.textColor = .lightGray
        locationCountLabel.textColor = .lightGray
        locationCountLimitLabel.textColor = .lightGray
        nickNameHintLabel.textColor = .lightGray
        
        PWCountLabel.textAlignment = .right
        locationCountLabel.textAlignment = .right
        
        IDHintLabel.font = UIFont.systemFont(ofSize: 14)
        PWHintLabel.font = UIFont.systemFont(ofSize: 14)
        PWCountLabel.font = UIFont.systemFont(ofSize: 14)
        PWCountLimitLabel.font = UIFont.systemFont(ofSize: 14)
        locationCountLabel.font = UIFont.systemFont(ofSize: 14)
        locationCountLimitLabel.font = UIFont.systemFont(ofSize: 14)
        nickNameHintLabel.font = UIFont.systemFont(ofSize: 14)
    }
    func setTextFieldUI() {
        IDTextField.placeholder = "이메일 주소 또는 전화번호"
        PWTextField.placeholder = "비밀번호"
        nickNameTextField.placeholder = "닉네임"
        locationTextField.placeholder = "위치"
        recommendCodeTextField.placeholder = "추천 코드 입력"
        
        IDTextField.setPlaceholder(color: .white)
        PWTextField.setPlaceholder(color: .white)
        nickNameTextField.setPlaceholder(color: .white)
        locationTextField.setPlaceholder(color: .white)
        recommendCodeTextField.setPlaceholder(color: .white)
        
        IDTextField.keyboardType = .default
        PWTextField.keyboardType = .default
        nickNameTextField.keyboardType = .default
        locationTextField.keyboardType = .default
        recommendCodeTextField.keyboardType = .numberPad
        
        IDTextField.textColor = .white
        PWTextField.textColor = .white
        nickNameTextField.textColor = .white
        locationTextField.textColor = .white
        recommendCodeTextField.textColor = .white
        
        IDTextField.textAlignment = .center
        PWTextField.textAlignment = .center
        nickNameTextField.textAlignment = .center
        locationTextField.textAlignment = .center
        recommendCodeTextField.textAlignment = .center
        
        IDTextField.borderStyle = .none
        PWTextField.borderStyle = .none
        nickNameTextField.borderStyle = .none
        locationTextField.borderStyle = .none
        recommendCodeTextField.borderStyle = .none
        
        PWTextField.isSecureTextEntry = true
        
        IDTextField.backgroundColor = .darkGray
        PWTextField.backgroundColor = .darkGray
        nickNameTextField.backgroundColor = .darkGray
        locationTextField.backgroundColor = .darkGray
        recommendCodeTextField.backgroundColor = .darkGray
    }
    func setRegisterButtonUI() {
        registerButton.setTitle("회원가입", for: .normal)
        registerButton.setTitleColor(.black, for: .normal)
        registerButton.backgroundColor = .white
    }
    func setSwitchUI() {
        additionalInfoSwitch.setOn(true, animated: true)
        additionalInfoSwitch.onTintColor = .red
        additionalInfoSwitch.thumbTintColor = .white
    }
}

extension UITextField {
    func setPlaceholder(color: UIColor) {
        guard let string = self.placeholder else {
            return
        }
        attributedPlaceholder = NSAttributedString(string: string, attributes: [.foregroundColor: color])
    }
}
