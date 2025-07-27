//
//  UILabel+Custom.swift
//  Shopping
//
//  Created by 정성희 on 7/27/25.
//

import UIKit

class CustomUILabel: UILabel {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(text: String, textColor: UIColor = .black, alignment: NSTextAlignment, size: CGFloat, weight: UIFont.Weight = .regular) {
        super.init(frame: .zero)
        
        self.text = text
        self.textColor = textColor
        self.textAlignment = alignment
        self.font = .systemFont(ofSize: size, weight: weight)
        self.numberOfLines = 2
    }
}
