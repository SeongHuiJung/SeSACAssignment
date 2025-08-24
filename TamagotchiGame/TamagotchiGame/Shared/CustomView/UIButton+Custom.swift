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

class ListButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let line1 = {
        let view = UIView()
        view.backgroundColor = .primary
        return view
    }()
    private let line2 = {
        let view = UIView()
        view.backgroundColor = .primary
        return view
    }()
    private var context = CustomUILabel(text: "", alignment: .left, size: 16, textColor: .black)
    private var nextMark = {
        let image = UIImageView(image: UIImage(systemName: "greaterthan"))
        image.tintColor = .primary
        return image
    }()
    
    init(title: String, iconName: String) {
        super.init(frame: .zero)
        self.backgroundColor = .second

        context.text = title
        
        let icon = UIImageView(image: UIImage(systemName: iconName))
        icon.tintColor = .primary

        [line1, line2, icon, context, nextMark].forEach { self.addSubview($0) }
        
        line1.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(0.2)
        }
        line2.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(0.2)
        }
        icon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.size.equalTo(24)
        }
        context.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(icon.snp.right).offset(12)
        }
        nextMark.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(20)
            make.size.equalTo(24)
        }
    }
}
