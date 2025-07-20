//
//  UpDownGameCollectionViewCell.swift
//  UpDownGame
//
//  Created by 정성희 on 7/21/25.
//

import UIKit

class UpDownGameCollectionViewCell: UICollectionViewCell {

    static let identifier = "UpDownGameCollectionViewCell"
    @IBOutlet var itemView: UIView!
    @IBOutlet var itemLabel: UILabel!
    var isSelectedForAnswer = false
    
    override var isSelected: Bool {
        didSet{
            if isSelected {
                itemLabel.textColor = .white
                itemView.backgroundColor = .black
            }
            else {
                itemLabel.textColor = .black
                itemView.backgroundColor = .white
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    private func configureUI() {
        itemLabel.font = .systemFont(ofSize: 12)
        itemLabel.textColor = .black
        itemLabel.textAlignment = .center
        
        itemView.backgroundColor = .white
        itemView.layer.cornerRadius = itemView.frame.height / 2
        itemView.clipsToBounds = true
    }
    
    func configure(value: String) {
        itemLabel.text = value
    }
}
