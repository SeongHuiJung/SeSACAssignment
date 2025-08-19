//
//  SimpleTableViewCell.swift
//  RxSwiftStudy
//
//  Created by 정성희 on 8/19/25.
//

import UIKit
import SnapKit

class SimpleTableViewCell: UITableViewCell {

    static let identifier = "SimpleTableViewCell"
    
    let label = {
        let label = UILabel()
        label.text = "test"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(16)
        }
    }
}
