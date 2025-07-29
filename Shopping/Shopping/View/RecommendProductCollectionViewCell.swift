//
//  RecommendProductCollectionViewCell.swift
//  Shopping
//
//  Created by 정성희 on 7/29/25.
//

import UIKit

class RecommendProductCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "RecommendProductCollectionViewCell"
    
    private let imageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
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

extension RecommendProductCollectionViewCell {
    func configureData(data: ShopItem) {
        imageView.setDownSamplingImage(url: data.image)
    }
}

extension RecommendProductCollectionViewCell: ViewDesignProtocol {
    func configureHierarchy() {
        [imageView].forEach { contentView.addSubview($0) }
    }
    
    func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    func configureView() {
        contentView.backgroundColor = .clear
    }
}
