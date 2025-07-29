//
//  SortTagCollectionViewCell.swift
//  Shopping
//
//  Created by 정성희 on 7/27/25.
//

import UIKit
import SnapKit

class SortTagCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SortTagCollectionViewCell"
    
    let tagCell = CustomSortTagView(text: "")
    
    // enum, 매서드로 개선
    var isSelectedTag: Bool = false {
        didSet {
            if isSelectedTag {
                tagCell.backgroundColor = .white
                tagCell.layer.borderColor = UIColor.black.cgColor
                tagCell.textLabel.textColor = .black
            }
            else {
                tagCell.backgroundColor = .black
                tagCell.layer.borderColor = UIColor.white.cgColor
                tagCell.textLabel.textColor = .white
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Data Set
extension SortTagCollectionViewCell {
    func configureData(text: String) {
        tagCell.textLabel.text = text
    }
}

// MARK: UI Delegate
extension SortTagCollectionViewCell: ViewDesignProtocol {
    func configureHierarchy() {
        contentView.addSubview(tagCell)
    }
    
    func configureLayout() {
        tagCell.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    func configureView() {
        self.backgroundColor = .clear
    }
}
