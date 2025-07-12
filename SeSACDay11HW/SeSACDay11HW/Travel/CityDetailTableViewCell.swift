//
//  TravelTableViewCell.swift
//  SeSACDay11HW
//
//  Created by 정성희 on 7/12/25.
//

import UIKit

class CityDetailTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var saveLabel: UILabel!
    
    @IBOutlet var gradeCollection: [UIImageView]!
    @IBOutlet var travelImage: UIImageView!
    @IBOutlet var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setLabelUI()
        setImageUI()
    }

    func setLabelUI() {
        titleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        
        descriptionLabel.font = .systemFont(ofSize: 13, weight: .regular)
        descriptionLabel.textColor = .gray
        descriptionLabel.textAlignment = .left
        descriptionLabel.numberOfLines = 0
        
        saveLabel.text = "저장"
        saveLabel.font = .systemFont(ofSize: 12, weight: .light)
        saveLabel.textColor = .lightGray
        saveLabel.textAlignment = .left
    }
    
    func setImageUI() {
        travelImage.contentMode = .scaleAspectFill
    }

    override func prepareForReuse() {
        for i in 0..<5 {
            gradeCollection[i].tintColor = .systemGray4
        }
    }
}
