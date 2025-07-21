//
//  NaverPayViewController.swift
//  CodeBaseUI
//
//  Created by 정성희 on 7/21/25.
//

import UIKit
import SnapKit

class NaverPayViewController: UIViewController {
    
    let membershipButton = UIButton()
    let spotPayButton = UIButton()
    let couponButton = UIButton()
    let buttonView = UIView()
    let exitButton = UIButton()
    
    let mainView = UIView()
    let logoImageView = UIImageView(image: UIImage(named: "naverpay"))
    let lockImageView = UIImageView(image: UIImage(named: "lock"))
    
    let desLabel = UILabel()
    let checkButton = UIButton()
    
    let payLabelView = UIView()
    let payLabel = UILabel()
    let payImageView = UIImageView(image: UIImage(named: "check"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        register()
        setSegmentLayout()
        setMainViewLayout()
    }
    
    func configure() {
        view.backgroundColor = .black
        
        membershipButton.setSegmentButtonDesign(text: "멤버십")
        spotPayButton.setSegmentButtonDesign(text: "현장결제")
        couponButton.setSegmentButtonDesign(text: "쿠폰")
        
        buttonView.backgroundColor = .black
        buttonView.layer.cornerRadius = 20
        buttonView.clipsToBounds = true
        
        mainView.backgroundColor = .white
        mainView.layer.cornerRadius = 20
        mainView.clipsToBounds = true
        
        exitButton.setImage(UIImage(named: "close"), for: .normal)
        
        lockImageView.contentMode = .scaleAspectFit
        
        desLabel.text = "한 번만 인증하고\n비밀번호 없이 결제하세요"
        desLabel.font = .systemFont(ofSize: 20, weight: .bold)
        desLabel.textColor = .black
        desLabel.textAlignment = .center
        desLabel.numberOfLines = 0

        checkButton.setTitle("확인", for: .normal)
        checkButton.backgroundColor = .systemGreen
        checkButton.layer.cornerRadius = 20
        checkButton.clipsToBounds = true
        
        payLabel.text = "바로결제 사용하기"
        payLabel.font = .systemFont(ofSize: 18, weight: .bold)
        payLabel.textColor = .black
        payLabel.textAlignment = .left
        payLabel.numberOfLines = 0
    }
    
    func register() {
        [buttonView, mainView].forEach { view.addSubview($0) }
        [membershipButton, spotPayButton, couponButton].forEach { buttonView.addSubview($0) }
        [logoImageView, exitButton, lockImageView, desLabel, checkButton, payLabelView].forEach { mainView.addSubview($0) }
        [payLabel, payImageView].forEach { payLabelView.addSubview($0) }
    }
    
    func setSegmentLayout() {
        buttonView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.height.equalTo(50)
        }
        
        membershipButton.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview().inset(8)
            make.width.equalTo(spotPayButton)
        }
        
        spotPayButton.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(8)
            make.leading.equalTo(membershipButton.snp.trailing).offset(8)
            make.trailing.equalTo(couponButton.snp.leading).offset(-8)
            make.width.equalTo(couponButton)
        }
        
        couponButton.snp.makeConstraints { make in
            make.verticalEdges.trailing.equalToSuperview().inset(8)
        }
    }
    
    func setMainViewLayout() {
        mainView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(buttonView.snp.bottom).offset(20)
            make.height.equalTo(500)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.left.top.equalToSuperview().inset(20)
            make.height.equalTo(28)
            make.width.equalTo(60)
        }
        
        exitButton.snp.makeConstraints { make in
            make.right.top.equalToSuperview().inset(20)
            make.height.width.equalTo(30)
        }
        
        lockImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(36)
            make.height.equalTo(160)
        }
        
        desLabel.snp.makeConstraints { make in
            make.top.equalTo(lockImageView.snp.bottom).offset(56)
            make.centerX.equalToSuperview()
        }
        
        checkButton.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        
        payLabelView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(checkButton.snp.top).offset(-40)
        }
        
        payImageView.snp.makeConstraints { make in
            make.verticalEdges.left.equalToSuperview()
            make.right.equalTo(payLabel.snp.left).offset(-5)
            make.height.width.equalTo(20)
        }
        
        payLabel.snp.makeConstraints { make in
            make.verticalEdges.right.equalToSuperview()
        }
    }
}

extension UIButton {
    func setSegmentButtonDesign(text: String) {
        self.setTitle(text, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = .darkGray
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
    }
}
