//
//  UITextField+Custom.swift
//  NetworkProject
//
//  Created by 정성희 on 7/24/25.
//

import UIKit
class CustomTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        
        self.borderStyle = .line
        self.textAlignment = .center
        self.backgroundColor = .white
        self.font = .systemFont(ofSize: 20, weight: .semibold)
        self.textColor = .black
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
    }
}
