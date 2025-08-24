//
//  UIButton+Custom.swift
//  SeSACDay8HW
//
//  Created by 정성희 on 8/23/25.
//

import UIKit
import SnapKit

class IconButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(title: String, size: CGFloat, textColor: UIColor, iconName: String) {
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: size, weight: .semibold)
        self.setTitleColor(textColor, for: .normal)
        self.backgroundColor = .clear
        self.layer.borderColor = UIColor.primary.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        let icon = UIImageView(image: UIImage(systemName: iconName))
        icon.tintColor = .primary
        self.addSubview(icon)
        icon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(12)
            make.size.equalTo(24)
        }
    }
}
