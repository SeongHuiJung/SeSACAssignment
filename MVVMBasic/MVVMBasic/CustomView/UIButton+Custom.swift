//
//  UIButton+Custom.swift
//  MovieShare
//
//  Created by 정성희 on 7/31/25.
//

import UIKit
import SnapKit

class ProfileButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(buttonImage: UIImage, borderColor : UIColor = .lightGray) {
        super.init(frame: .zero)
        self.setImage(buttonImage, for: .normal)
        self.backgroundColor = .clear
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 60
        self.clipsToBounds = true
    }
}

class CameraButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        self.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        self.backgroundColor = .systemBlue
        self.tintColor = .white
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
    }
}

class MBTIButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let label = CustomUILabel(text: "", alignment: .center, size: 20, textColor: .gray)
    var isOn = false
    
    init(text: String, borderColor: UIColor = .lightGray) {
        super.init(frame: .zero)
        
        self.addSubview(label)
        label.text = text
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        self.backgroundColor = .white
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 25
        self.clipsToBounds = true
    }
}

class RoundButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title: String, size: CGFloat, background: UIColor) {
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: size, weight: .bold)
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = background
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
    }
}
