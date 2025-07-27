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
    
    private var isLike = false {
        didSet {
            if isLike {
                likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }
            else {
                likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            }
        }
    }
    
    private let imageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    private let brandLabel = CustomUILabel(text: "brand", textColor: .lightGray, alignment: .left, size: 13, weight: .light)
    private let titleLabel = CustomUILabel(text: "", textColor: .white, alignment: .left, size: 14)
    private let priceLabel = CustomUILabel(text: "", textColor: .white, alignment: .left, size: 15, weight: .semibold)
    
    private let likeButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .black
        
        // View Cycle 고려하여 나중에 호출되도록 함
        DispatchQueue.main.async {
            button.layer.cornerRadius = button.bounds.width / 2
            button.clipsToBounds = true
        }
        return button
    }()
    
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

// MARK: - Loginc
extension ProductListCollectionViewCell {
    @objc func likeButtonTapped() {
        isLike = !isLike
    }
}

// MARK: - Data Set
extension ProductListCollectionViewCell {
    func configureData(data: ShopItem) {
        imageView.setDownSamplingImage(url: data.image)
        brandLabel.text = data.brand
        priceLabel.text = NumberFomatterSingleton.shared.foarmatter.string(from: Int(data.lprice)! as NSNumber)
        titleLabel.text = data.title.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
    }
}

// MARK: UI Delegate
extension ProductListCollectionViewCell: ViewDesignProtocol {
    func configureHierarchy() {
        [imageView, likeButton, brandLabel, titleLabel, priceLabel].forEach { contentView.addSubview($0) }
    }
    
    func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView)
            make.top.equalTo(contentView)
            make.height.equalTo(imageView.snp.width)
        }
        
        likeButton.snp.makeConstraints { make in
            make.right.equalTo(imageView.snp.right).inset(10)
            make.bottom.equalTo(imageView.snp.bottom).inset(10)
            make.size.equalTo(32)
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
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
}
