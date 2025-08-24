//
//  OnboardingCollectionViewCell.swift
//  SeSACDay8HW
//
//  Created by 정성희 on 8/24/25.
//

import UIKit
import SnapKit

class OnboardingCollectionViewCell: BaseCollectionViewCell {
    static let identifier = "OnboardingCollectionViewCell"
    
    let image = {
        let image = UIImageView()
        image.backgroundColor = .clear
        return image
    }()
    let namePaddingView = {
        let view = UIView()
        view.backgroundColor = .second
        view.layer.borderColor = UIColor.primary.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()
    let name = CustomUILabel(text: "test", alignment: .center, size: 13, textColor: .primary)
    
    override func configureHierarchy() {
        super.configureHierarchy()
        [image, namePaddingView, name].forEach { contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        super.configureLayout()
        image.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(image.snp.width)
            make.top.equalToSuperview()
        }
        namePaddingView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(image.snp.bottom).offset(12)
            make.height.equalTo(28)
        }
        name.snp.makeConstraints { make in
            make.edges.equalTo(namePaddingView).inset(4)
        }
    }
    
    override func configureView() {
        super.configureView()
    }
}

extension OnboardingCollectionViewCell {
    func configureData(tamagotchiType: TamagotchiType) {
        if tamagotchiType == .none { image.image = UIImage(named: "noImage") }
        else { image.image = UIImage(named: "\(tamagotchiType.rawValue)-6") }
        
        name.text = tamagotchiType.krName
    }
}
