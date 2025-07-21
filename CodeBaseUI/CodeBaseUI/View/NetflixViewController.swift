//
//  NetflixViewController.swift
//  CodeBaseUI
//
//  Created by 정성희 on 7/21/25.
//

import UIKit

class NetflixViewController: UIViewController {

    let titleLabel = UILabel()
    
    let emailOrPhoneNumberTextField = UITextField()
    let passwordTextField = UITextField()
    let nicknameTextField = UITextField()
    let locationTextField = UITextField()
    let recommendTextField = UITextField()
    
    let registerTextButton = UIButton()
    let hintLabel = UILabel()
    let infoSwitch = UISwitch()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        register()
        setLayout()
    }

    func register() {
        [titleLabel, emailOrPhoneNumberTextField, passwordTextField, nicknameTextField, locationTextField, recommendTextField, registerTextButton, hintLabel, infoSwitch].forEach { view.addSubview($0) }
    }
    
    func configure() {
        view.backgroundColor = .black
        
        titleLabel.text = "JACKFLIX"
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = .red
        titleLabel.textAlignment = .center

        emailOrPhoneNumberTextField.text = "이메일 주소 또는 전화번호"
        passwordTextField.text = "비밀번호"
        nicknameTextField.text = "닉네임"
        locationTextField.text = "위치"
        recommendTextField.text = "추천 코드 입력"
        
        [emailOrPhoneNumberTextField, passwordTextField, nicknameTextField, locationTextField, recommendTextField].forEach {
            $0.textColor = .systemGray6
            $0.backgroundColor = .darkGray
            $0.textAlignment = .center
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
        }
        
        registerTextButton.setTitle("회원가입", for: .normal)
        registerTextButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        registerTextButton.setTitleColor(.black, for: .normal)
        registerTextButton.backgroundColor = .white
        registerTextButton.layer.cornerRadius = 10
        registerTextButton.clipsToBounds = true
        
        hintLabel.text = "추가 정보 입력"
        hintLabel.font = .systemFont(ofSize: 13)
        hintLabel.textColor = .white
        hintLabel.textAlignment = .left
    }
    
    func setLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.centerX.equalToSuperview()
        }
        
        emailOrPhoneNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(50)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(36)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailOrPhoneNumberTextField.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(36)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(36)
        }
        
        locationTextField.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(36)
        }
        
        recommendTextField.snp.makeConstraints { make in
            make.top.equalTo(locationTextField.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(36)
        }
        
        registerTextButton.snp.makeConstraints { make in
            make.top.equalTo(recommendTextField.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        hintLabel.snp.makeConstraints { make in
            make.top.equalTo(registerTextButton.snp.bottom).offset(16)
            make.left.equalTo(registerTextButton.snp.left)
        }
        
        infoSwitch.snp.makeConstraints { make in
            make.top.equalTo(registerTextButton.snp.bottom).offset(16)
            make.right.equalTo(registerTextButton.snp.right)
        }
    }
}
