//
//  UILabel+Custom.swift
//  SeSACDay8HW
//
//  Created by 정성희 on 8/23/25.
//

import UIKit

class CustomUILabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(text: String, alignment: NSTextAlignment, size: CGFloat, weight: UIFont.Weight = .regular, textColor: UIColor = .font, numberOfLines: Int = 0) {
        super.init(frame: .zero)
        
        self.text = text
        self.textColor = textColor
        self.textAlignment = alignment
        self.font = .systemFont(ofSize: size, weight: weight)
        self.numberOfLines = numberOfLines
    }
}
