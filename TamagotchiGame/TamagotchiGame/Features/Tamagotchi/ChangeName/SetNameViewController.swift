//
//  SetNameViewController.swift
//  TamagotchiGame
//
//  Created by 정성희 on 8/24/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SetNameViewController: TamagotchiBaseViewController {

    private let viewModel = SetNameViewModel()
    private let textField = CustomTextField(text: "", placeholder: "이름을 입력해주세요", size: 16)
    private let line = {
        let view = UIView()
        view.backgroundColor = .primary
        return view
    }()
    lazy private var barButton = UIBarButtonItem(title: "저장")

    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        [textField, line].forEach { view.addSubview($0) }
    }
    
    override func configureLayout() {
        super.configureLayout()
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        line.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(2)
            make.horizontalEdges.equalTo(textField)
            make.height.equalTo(1)
        }
    }
    
    override func configureView() {
        super.configureView()
        navigationItem.title = "대장님 이름 정하기"
        navigationItem.rightBarButtonItem = barButton
    }
}

// MARK: - Bind
extension SetNameViewController {
    func bind() {
        let input = SetNameViewModel.Input(saveButtonTapped: barButton.rx.tap, name: textField.rx.text.orEmpty)
        let output = viewModel.transform(input: input)
        
        output.nameSetCompleted
            .bind(with: self) { owner, _ in
                print("??")
                owner.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }
}
