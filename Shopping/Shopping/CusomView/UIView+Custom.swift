//
//  UIView+Custom.swift
//  Shopping
//
//  Created by 정성희 on 7/27/25.
//

import UIKit
import SnapKit

class CustomSortTagView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let textLabel = CustomUILabel(text: "", textColor: .white, alignment: .center, size: 15)
    
    init(text: String) {
        super.init(frame: .zero)
        
        textLabel.text = text
        self.addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        self.backgroundColor = .black
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
}
