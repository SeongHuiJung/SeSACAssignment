//
//  MBTISetViewController.swift
//  MVVMBasic
//
//  Created by 정성희 on 8/10/25.
//

import UIKit
import SnapKit

class MBTISetViewController: BaseViewController {

    let viewModel = MBTISetViewModel()
    
    private let profileSetView = ProfileSetView()
    private let textField = CustomTextField(text: "", placeholder: "닉네임을 입력해주세요 :)", size: 15)
    private let textFieldLine = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    private let hintLabel = {
        let lable = CustomUILabel(text: "", alignment: .left, size: 13, textColor: .blue)
        return lable
    }()
    private let MBTILable = CustomUILabel(text: "MBTI", alignment: .left, size: 18, weight: .semibold, numberOfLines: 1)
    private let completeButton = RoundButton(title: "완료", size: 18, background: .gray)

    private let eButton = MBTIButton(text: "E")
    private let sButton = MBTIButton(text: "S")
    private let tButton = MBTIButton(text: "T")
    private let jButton = MBTIButton(text: "J")
    private let iButton = MBTIButton(text: "I")
    private let nButton = MBTIButton(text: "N")
    private let fButton = MBTIButton(text: "F")
    private let pButton = MBTIButton(text: "P")

    private let estjStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 12
        return stack
    }()

    private let infpStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 12
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupActions()
        setViewModelClosure()
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        [profileSetView, textField, textFieldLine, hintLabel, MBTILable, estjStackView, infpStackView, completeButton].forEach { view.addSubview($0) }

        [eButton, sButton, tButton, jButton].forEach {
            estjStackView.addArrangedSubview($0)
        }
        [iButton, nButton, fButton, pButton].forEach {
            infpStackView.addArrangedSubview($0)
        }

    }
    
    override func configureConstraint() {
        super.configureConstraint()
        profileSetView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(28)
            make.centerX.equalToSuperview()
            make.size.equalTo(120)
        }
        textField.snp.makeConstraints { make in
            make.top.equalTo(profileSetView.snp.bottom).offset(28)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        textFieldLine.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(textField)
            make.height.equalTo(0.5)
        }
        hintLabel.snp.makeConstraints { make in
            make.top.equalTo(textFieldLine.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(textField)
        }
        MBTILable.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(80)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        estjStackView.snp.makeConstraints { make in
            make.top.equalTo(MBTILable)
            make.left.equalTo(MBTILable.snp.right).offset(80)
            make.right.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        infpStackView.snp.makeConstraints { make in
            make.top.equalTo(estjStackView.snp.bottom).offset(12)
            make.left.equalTo(estjStackView)
            make.right.equalTo(estjStackView)
        }
        [eButton, sButton, tButton, jButton, iButton, nButton, fButton, pButton].forEach {
            $0.snp.makeConstraints { make in
                make.size.equalTo(50)
            }
        }
        completeButton.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
        
        MBTILable.setContentCompressionResistancePriority(UILayoutPriority(1001), for: .horizontal)
    }
    
    private func setupActions() {
        
        textField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    private func setViewModelClosure() {
        viewModel.fetchHintText = {
            self.hintLabel.text = self.viewModel.hintText
        }
    }
    
    @objc func textFieldChanged() {
        print(#function)
        viewModel.nickname = textField.text
    }
}
