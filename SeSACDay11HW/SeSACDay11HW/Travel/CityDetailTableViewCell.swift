//
//  CityDetailTableViewCell.swift
//  SeSACDay11HW
//
//  Created by 정성희 on 7/14/25.
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
        
        travelImage.kf.indicatorType = .activity
        
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
        
        saveLabel.text = "저장 0"
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
    
    // 이 함수가 여기에 포함되는게 맞을까?
    func getCommaNum(value: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(for: value)!
        
        return result
    }
    
    func configureDefaultCellUI(row: Travel) {
        titleLabel.text = row.title
        descriptionLabel.text = row.description
        
        if let saveCount = row.save  {
            let commaNum = getCommaNum(value: saveCount)
            saveLabel.text = "저장 \(commaNum)"
        }
        else {
            saveLabel.text = "저장 0"
        }
        
        if let url = URL(string: row.travel_image ?? "") {
            
            travelImage.kf.setImage(with: url)
        }
        else {
            travelImage.image = UIImage(systemName: "xmark.diamond.fill")
        }
        
        if row.like == true {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
        if let grade = row.grade {
            let grade = Int(round(grade))
            for i in 0..<grade {
                gradeCollection[i].tintColor = .yellow
            }
        }
    }
}
