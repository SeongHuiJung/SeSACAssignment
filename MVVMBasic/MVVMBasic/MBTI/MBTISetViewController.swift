//
//  MBTISetViewController.swift
//  MVVMBasic
//
//  Created by 정성희 on 8/10/25.
//

import UIKit
import SnapKit

enum MBTIType: String {
    case E, S, T, J, I, N, F, P
      
    var partner: MBTIType {
        switch self {
        case .E : .I
        case .S : .N
        case .T : .F
        case .J : .P
        case .I : .E
        case .N : .S
        case .F : .T
        case .P : .J
        }
    }
    
    var index: Int {
        switch self {
        case .E : 0
        case .S : 1
        case .T : 2
        case .J : 3
        case .I : 4
        case .N : 5
        case .F : 6
        case .P : 7
        }
    }
}

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
    private let completeButton = RoundButton(title: "완료", size: 18, background: .buttonDeactivate)
    
    private let MBTIButtons = [
        MBTIButton(text: MBTIType.E.rawValue),
        MBTIButton(text: MBTIType.S.rawValue),
        MBTIButton(text: MBTIType.T.rawValue),
        MBTIButton(text: MBTIType.J.rawValue),
        MBTIButton(text: MBTIType.I.rawValue),
        MBTIButton(text: MBTIType.N.rawValue),
        MBTIButton(text: MBTIType.F.rawValue),
        MBTIButton(text: MBTIType.P.rawValue)
    ]
    
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
        
        MBTIButtons[0...3].forEach {
            estjStackView.addArrangedSubview($0)
        }
        MBTIButtons[4...7].forEach {
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
        MBTIButtons.forEach {
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
        MBTIButtons.forEach { $0.addTarget(self, action: #selector(mbtiButtonTapped), for: .touchUpInside)
        }
        
        textField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
        completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
    }
    
    // 1. enum 으로 받기
    // 2. enum 없이 변경
    // 3. dictionary 으로 변경하기
    private func setViewModelClosure() {
        viewModel.fetchHintText = {
            self.hintLabel.text = self.viewModel.outputHintText
        }
        
        viewModel.fetchMBTIButtonStatus = {
            let selectMBTI = self.viewModel.outputMBTIResult.0
            let selectMBTIIndex = selectMBTI.0
            let selectMBTIIsOn = selectMBTI.1
            
            let partnerMBTI = self.viewModel.outputMBTIResult.1
            let partnerMBTIIndex = partnerMBTI.0
            let partnerMBTIIsOn = partnerMBTI.1

            self.MBTIButtons[selectMBTIIndex].isOn = selectMBTIIsOn
            self.MBTIButtons[partnerMBTIIndex].isOn = partnerMBTIIsOn
            
            self.fetchMBTIUI(result: selectMBTIIsOn, index: selectMBTIIndex)
            self.fetchMBTIUI(result: partnerMBTIIsOn, index: partnerMBTIIndex)
        }
    
        viewModel.fetchCompleteStatus = {
            if self.viewModel.outputIsValideSetUpProfile {
                self.completeButton.backgroundColor = .buttonActive
            }
            else {
                self.completeButton.backgroundColor = .buttonDeactivate
            }
        }
    }
    
    // result 에 두개 넣기?
    private func fetchMBTIUI(result: Bool, index: Int) {
        if result {
            self.MBTIButtons[index].backgroundColor = .systemBlue
            self.MBTIButtons[index].label.textColor = .white
        }
        else {
            self.MBTIButtons[index].backgroundColor = .white
            self.MBTIButtons[index].label.textColor = .gray
        }
    }
    
    @objc func textFieldChanged() {
        viewModel.nickname = textField.text
    }
    
    @objc func mbtiButtonTapped(_ sender: MBTIButton) {
        let partnerIndex = MBTIType(rawValue: sender.label.text!)?.partner.index ?? 0
        viewModel.inputMBTIData = ["selectMBTI" :  sender.label.text!,
                                   "selectIsOn" : "\(sender.isOn)",
                                   "partnerIsOn" : "\(MBTIButtons[partnerIndex].isOn)"]
        
        viewModel.checkMBTISignal = ()
        
        var isOnCount = 0
        MBTIButtons.forEach { if $0.isOn { isOnCount += 1 } }
        viewModel.inputIsOnCount = isOnCount
    }
    
    @objc func completeButtonTapped() {
        if viewModel.outputIsValideSetUpProfile {
            let alert = UIAlertController(title: "프로필 저장", message: "프로필 내용을 성공적으로 저장했어요!", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "확인", style: .default)
            alert.addAction(okButton)
            present(alert, animated: true)
        }
        else {
            let alert = UIAlertController(title: "프로필 저장", message: "아직 프로필 내용이 모두 기입되지 않았어요‼️", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "확인", style: .default)
            alert.addAction(okButton)
            present(alert, animated: true)
        }
    }
}
