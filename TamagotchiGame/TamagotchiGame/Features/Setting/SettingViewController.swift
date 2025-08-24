//
//  SettingViewController.swift
//  TamagotchiGame
//
//  Created by 정성희 on 8/24/25.
//

import UIKit
import SnapKit
import RxSwift

class SettingViewController: BaseViewController {

    let stack = CustomStackView(axis: .vertical, alignment: .fill, spacing: 0)
    let nameSetButton = ListButton(title: "내 이름 설정하기", iconName: "pencil")
    let changeTamagotchiButton = ListButton(title: "다마고치 변경하기", iconName: "moon.fill")
    let resetButton = ListButton(title: "데이터 초기화", iconName: "trash.fill")
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        view.addSubview(stack)
        [nameSetButton, changeTamagotchiButton, resetButton].forEach { stack.addArrangedSubview($0) }
    }
    
    override func configureLayout() {
        super.configureLayout()
        stack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        nameSetButton.snp.makeConstraints { make in
            make.height.equalTo(52)
        }
        changeTamagotchiButton.snp.makeConstraints { make in
            make.height.equalTo(52)
        }
        resetButton.snp.makeConstraints { make in
            make.height.equalTo(52)
        }
    }
    
    override func configureView() {
        super.configureView()
        navigationItem.title = "설정"
        
        nameSetButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.navigationController?.pushViewController(SetNameViewController(), animated: true)
            }
            .disposed(by: disposeBag)
        
        changeTamagotchiButton.rx.tap
            .bind(with: self) { owner, _ in
//                owner.navigationController?.pushViewController(SetNameViewController(), animated: true)
            }
            .disposed(by: disposeBag)
        
        resetButton.rx.tap
            .bind(with: self) { owner, _ in
                
            }
            .disposed(by: disposeBag)
    }
}

