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

    private let disposeBag = DisposeBag()
    
    private let viewModel = SimpleValidationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addBind()
    }
    
    private func addBind() {
        
        let usernameValid = usernameTextField.rx.text.orEmpty
        let passwordValid = passwordTextField.rx.text.orEmpty
        let actionButtonTapped = actionButton.rx.tap
        
        let input = SimpleValidationViewModel.Input(usernameChanged: usernameValid, passwordChanged: passwordValid, actionButtonTapped: actionButtonTapped)
        
        let output = viewModel.transform(input: input)
        
        output.usernameValid
            .bind(to: usernameValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        output.passwordValid
            .bind(to: passwordValidLabel.rx.isHidden)
            .disposed(by: disposeBag)

        
        output.everythingValid
            .bind(with: self) { owner, colorType in
                owner.actionButton.backgroundColor = colorType.color
            }
            .disposed(by: disposeBag)
        
        output.usernameHintText
            .bind(to: usernameValidLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.passwordHintText
            .bind(to: passwordValidLabel.rx.text)
            .disposed(by: disposeBag)
        
        // customObservable 과는 다르게
        // 값 변경이 먼저 되고(방출/emit), 이 후에 bind 설정(구독)이 되더라도
        // rxSwift 는 해당 emit 에 대해 반응할 수 있다 -> 화면 진입하자마자 시행되면 안되는 코드를 주의해야할 것 같음
        output.actionButtonTapped
            .bind(with: self) { owner, isTapped in
                if isTapped { owner.showAlert() }
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
    }
}
