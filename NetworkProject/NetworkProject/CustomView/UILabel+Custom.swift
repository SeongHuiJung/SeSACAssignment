//
//  UILabel+Custom.swift
//  NetworkProject
//
//  Created by 정성희 on 7/23/25.
//

import UIKit

class LottoBlackUILabel: UILabel {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.textColor = .black
        self.textAlignment = .left
    }
}

class LottoWinUILabel: UILabel {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.textColor = .white
        self.textAlignment = .center
        self.font = .systemFont(ofSize: 20, weight: .semibold)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
}
