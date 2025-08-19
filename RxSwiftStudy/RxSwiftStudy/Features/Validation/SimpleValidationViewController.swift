//
//  SimpleValidationViewController.swift
//  RxSwiftStudy
//
//  Created by 정성희 on 8/19/25.
//

import UIKit
import RxSwift
import RxCocoa

class SimpleValidationViewController: UIViewController {

    let usernameTextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "이름을 입력하세요"
        return textField
    }()
    let usernameValidLabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    let passwordTextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "비밀번호를 입력하세요"
        textField.isSecureTextEntry = true
        return textField
    }()
    let passwordValidLabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    let actionButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("로그인", for: .normal)
        return button
    }()
    
    private let minimalUsernameLength = 5
    private let minimalPasswordLength = 5
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addBind()
    }
    
    private func addBind() {
        // MARK: observable
        let usernameValid = usernameTextField.rx.text.orEmpty
            .map { $0.count >= self.minimalUsernameLength } // TODO: operator 에서 발생할 수 있는 순환참조를 해결하는 방법?
            .share(replay: 1)
        
        let passwordValid = passwordTextField.rx.text.orEmpty
            .map { $0.count >= self.minimalPasswordLength }
            .share(replay: 1)
        
        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { (username, password) -> UIColor in
            return username && password ? .systemBlue : .lightGray
            }
            .share(replay: 1)
        
        // MARK: observer
        usernameValid
            .bind(to: usernameValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        passwordValid
            .bind(to: passwordValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        everythingValid
            .bind(to: actionButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        actionButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.showAlert()
            }
            .disposed(by: disposeBag)
    }
    
    func showAlert() {
        let alert = UIAlertController(
            title: "RxExample",
            message: "This is wonderful",
            preferredStyle: .alert
        )
        let defaultAction = UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func configure() {
        [usernameTextField, usernameValidLabel, passwordTextField, passwordValidLabel, actionButton].forEach { view.addSubview($0) }
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.horizontalEdges.equalTo(view.safeAreaInsets).inset(12)
            make.height.equalTo(44)
        }
        usernameValidLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(view.safeAreaInsets).inset(12)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameValidLabel.snp.bottom).offset(32)
            make.horizontalEdges.equalTo(view.safeAreaInsets).inset(12)
            make.height.equalTo(44)
        }
        passwordValidLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(view.safeAreaInsets).inset(12)
        }
        
        actionButton.snp.makeConstraints { make in
            make.top.equalTo(passwordValidLabel.snp.bottom).offset(32)
            make.horizontalEdges.equalTo(view.safeAreaInsets).inset(12)
        }
        
        usernameValidLabel.text = "이름은 \(minimalUsernameLength)글자 이상 입력해주세요"
        passwordValidLabel.text = "비밀번호는 \(minimalPasswordLength)글자 이상 입력해주세요"
    }
}
