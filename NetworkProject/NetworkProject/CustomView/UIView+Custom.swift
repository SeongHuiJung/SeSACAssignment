//
//  UIView+Custom.swift
//  NetworkProject
//
//  Created by 정성희 on 7/23/25.
//

import UIKit

class LottoWinView: UIView {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(label)
        label.textColor = .white
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
    }
}
