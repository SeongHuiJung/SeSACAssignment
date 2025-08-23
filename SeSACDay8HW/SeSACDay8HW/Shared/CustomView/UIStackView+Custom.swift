//
//  UIStackView+Custom.swift
//  SeSACDay8HW
//
//  Created by 정성희 on 8/23/25.
//

import UIKit

class CustomStackView: UIStackView {
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(axis: NSLayoutConstraint.Axis, alignment: UIStackView.Alignment, spacing: CGFloat) {
        super.init(frame: .zero)
        
        self.axis = axis
        self.alignment = alignment
        self.distribution = .fill
        self.spacing = spacing
    }
}
