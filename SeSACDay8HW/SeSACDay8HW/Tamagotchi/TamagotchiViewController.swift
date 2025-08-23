//
//  TamagotchiViewController.swift
//  SeSACDay8HW
//
//  Created by 정성희 on 8/22/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class TamagotchiViewController: BaseViewController {

    private let viewModel = TamagotchiViewModel()
    
    private let bubbleImage = {
        let image = UIImageView(image: UIImage(named: "bubble"))
        return image
    }()
    
    private let tamagotchiSpeechLabel = CustomUILabel(text: "testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest", alignment: .center, size: 15, weight: .semibold, textColor: .primary)
    private let tamagotchiImage = {
        let image = UIImageView(image: UIImage(named: "1-1"))
        return image
    }()
    private let tamagotchiLabel = CustomUILabel(text: "test", alignment: .center, size: 16, weight: .semibold, textColor: .primary)
    
    private let stateLabel = CustomUILabel(text: "test", alignment: .center, size: 15, weight: .regular, textColor: .primary)
    
    private let riceTextField = CustomTextField(text: "rice", placeholder: "냠냠", size: 15, alignment: .center, textColor: .primary)
    private let waterTextField = CustomTextField(text: "water", placeholder: "물물", size: 15, alignment: .center, textColor: .primary)
    
    private let lineView1 = {
        let view = UIView()
        view.backgroundColor = .primary
        return view
    }()
    private let lineView2 = {
        let view = UIView()
        view.backgroundColor = .primary
        return view
    }()
    
    private let riceButton = IconButton(title: "test", size: 16, textColor: .primary, iconName: "fork.knife.circle")
    private let waterButton = IconButton(title: "test", size: 16, textColor: .primary, iconName: "drop.circle")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "대장님의 다마고치"
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        [bubbleImage, tamagotchiSpeechLabel, tamagotchiImage, tamagotchiLabel, stateLabel, riceTextField, waterTextField, lineView1, lineView2, riceButton, waterButton].forEach { view.addSubview($0) }
    }
    
    override func configureLayout() {
        super.configureLayout()
        bubbleImage.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(52)
        }
        tamagotchiSpeechLabel.snp.makeConstraints { make in
            make.edges.equalTo(bubbleImage).inset(16)
        }
        tamagotchiImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bubbleImage.snp.bottom).offset(10)
        }
        tamagotchiLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(tamagotchiImage.snp.bottom).offset(10)
        }
        stateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(tamagotchiLabel.snp.bottom).offset(10)
        }
        riceTextField.snp.makeConstraints { make in
            make.top.equalTo(stateLabel.snp.bottom).offset(28)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(80)
            make.width.equalTo(160)
            make.height.equalTo(40)
        }
        lineView1.snp.makeConstraints { make in
            make.top.equalTo(riceTextField.snp.bottom)
            make.horizontalEdges.equalTo(riceTextField)
            make.height.equalTo(1)
        }
        riceButton.snp.makeConstraints { make in
            make.top.equalTo(riceTextField.snp.top).offset(4)
            make.left.equalTo(riceTextField.snp.right).offset(12)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        
        waterTextField.snp.makeConstraints { make in
            make.top.equalTo(riceTextField.snp.bottom).offset(12)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(80)
            make.width.equalTo(160)
            make.height.equalTo(40)
        }
        lineView2.snp.makeConstraints { make in
            make.top.equalTo(waterTextField.snp.bottom)
            make.horizontalEdges.equalTo(waterTextField)
            make.height.equalTo(1)
        }
        waterButton.snp.makeConstraints { make in
            make.top.equalTo(waterTextField.snp.top).offset(4)
            make.left.equalTo(waterTextField.snp.right).offset(12)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
    }

    override func configureView() {
        super.configureView()
    }
}

extension TamagotchiViewController {
    func bind() {
        
        let input = TamagotchiViewModel.Input()
    }
}
