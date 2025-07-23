//
//  UIStackView+Custom.swift
//  NetworkProject
//
//  Created by 정성희 on 7/23/25.
//

import UIKit

class CustomStackViewHorizontal: UIStackView {
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.axis = .horizontal
        self.alignment = .center
        self.distribution = .fill
        self.spacing = 4
    }
}
