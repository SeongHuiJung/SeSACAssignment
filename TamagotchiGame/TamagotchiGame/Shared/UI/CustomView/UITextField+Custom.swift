//
//  UITextField+Custom.swift
//  SeSACDay8HW
//
//  Created by 정성희 on 8/23/25.
//

import UIKit

class CustomTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(text: String, placeholder : String, size: CGFloat, weight: UIFont.Weight = .regular, alignment: NSTextAlignment = .left, textColor: UIColor = .font, canEdit: Bool = true) {
        super.init(frame: .zero)
        self.text = text
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        self.backgroundColor = .second
        self.font = .systemFont(ofSize: size, weight: weight)
        self.textColor = textColor
        self.borderStyle = .none

        // 입력하는 부분 왼쪽에 간격 추가
        self.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10, height: 0.0))
        self.leftViewMode = .always
        
        self.isUserInteractionEnabled = canEdit
    }
}
