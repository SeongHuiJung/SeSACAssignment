//
//  ProductListCollectionViewCell.swift
//  Shopping
//
//  Created by 정성희 on 7/27/25.
//

import UIKit
import SnapKit
import Kingfisher

class ProductListCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ProductListCollectionViewCell"
    
    private let imageView = UIImageView()
    private let brandLabel = CustomUILabel(text: "brand", textColor: .lightGray, alignment: .left, size: 13, weight: .light)
    private let titleLabel = CustomUILabel(text: "", textColor: .white, alignment: .left, size: 14)
    private let priceLabel = CustomUILabel(text: "", textColor: .white, alignment: .left, size: 15, weight: .semibold)
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
}

// MARK: - Data Set
extension ProductListCollectionViewCell {
    func configureData(data: ShopItem) {
        imageView.setDownSamplingImage(url: data.image)
        brandLabel.text = data.brand
        priceLabel.text = data.lprice
        titleLabel.text = data.title.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
    }
}

extension ProductListCollectionViewCell: ViewDesignProtocol {
    func configureHierarchy() {
        [imageView, brandLabel, titleLabel, priceLabel].forEach { contentView.addSubview($0) }
    }
    
    func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView)
            make.top.equalTo(contentView)
            make.height.equalTo(imageView.snp.width)
        }
        
        brandLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(contentView).inset(10)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(brandLabel.snp.bottom).offset(6)
            make.horizontalEdges.equalTo(contentView).inset(10)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.horizontalEdges.equalTo(contentView).inset(10)
        }
    }
    
    func configureView() {
        contentView.backgroundColor = .clear
    }
}
