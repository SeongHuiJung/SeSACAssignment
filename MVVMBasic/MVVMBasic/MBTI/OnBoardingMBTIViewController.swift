//
//  OnBoardingMBTIViewController.swift
//  MVVMBasic
//
//  Created by 정성희 on 8/10/25.
//

import UIKit
import SnapKit

class OnBoardingMBTIViewController: BaseViewController {

    let showNextPageButton = {
        let button = UIButton()
        button.setTitle("MBTI 설정 화면으로 이동", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
    }

    override func configureHierarchy() {
        super.configureHierarchy()
        view.addSubview(showNextPageButton)
        print(#function)
    }
    
    override func configureConstraint() {
        super.configureConstraint()
        showNextPageButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setupActions() {
        showNextPageButton.addTarget(self, action: #selector(goToMBTISetVC), for: .touchUpInside)
    }
    
    @objc private func goToMBTISetVC() {
        navigationController?.pushViewController(MBTISetViewController(), animated: true)
    }
}
