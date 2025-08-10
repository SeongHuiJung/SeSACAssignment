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
        MBTIButton(text: "E"),
        MBTIButton(text: "S"),
        MBTIButton(text: "T"),
        MBTIButton(text: "J"),
        MBTIButton(text: "I"),
        MBTIButton(text: "N"),
        MBTIButton(text: "F"),
        MBTIButton(text: "P"),
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
    }
    
    private func setViewModelClosure() {
        viewModel.fetchHintText = {
            self.hintLabel.text = self.viewModel.hintText
        }
        
        viewModel.fetchEStatus = {
            self.fetchMBTIUI(result: self.viewModel.outputEResult, index: MBTIType.E.index)
        }
        
        viewModel.fetchIStatus = {
            self.fetchMBTIUI(result: self.viewModel.outputIResult, index: MBTIType.I.index)
        }
        
        viewModel.fetchSStatus = {
            self.fetchMBTIUI(result: self.viewModel.outputSResult, index: MBTIType.S.index)
        }
        
        viewModel.fetchNStatus = {
            self.fetchMBTIUI(result: self.viewModel.outputNResult, index: MBTIType.N.index)
        }
        
        viewModel.fetchTStatus = {
            self.fetchMBTIUI(result: self.viewModel.outputTResult, index: MBTIType.T.index)
        }
        
        viewModel.fetchFStatus = {
            self.fetchMBTIUI(result: self.viewModel.outputFResult, index: MBTIType.F.index)
        }
        
        viewModel.fetchJStatus = {
            self.fetchMBTIUI(result: self.viewModel.outputJResult, index: MBTIType.J.index)
        }
        
        viewModel.fetchPStatus = {
            self.fetchMBTIUI(result: self.viewModel.outputPResult, index: MBTIType.P.index)
        }
    }
    
    private func fetchMBTIUI(result: Bool, index: Int) {
        if result {
            self.MBTIButtons[index].backgroundColor = .systemBlue
            self.MBTIButtons[index].label.textColor = .white
        }
        else {
            self.MBTIButtons[index].backgroundColor = .white
            self.MBTIButtons[index].label.textColor = .gray
        }
        self.MBTIButtons[index].isOn = result
    }
    
    @objc func textFieldChanged() {
        print(#function)
        viewModel.nickname = textField.text
    }
    
    @objc func mbtiButtonTapped(_ sender: MBTIButton) {
        print(#function)
        viewModel.mbtiSelect = sender
        viewModel.mbtiButtonList = MBTIButtons
        viewModel.checkMBTISignal = ()
    }
}
