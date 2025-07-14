//
//  MagazineTableViewCell.swift
//  SeSACDay11HW
//
//  Created by 정성희 on 7/14/25.
//

import UIKit

class MagazineTableViewCell: UITableViewCell {
    @IBOutlet var photoImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }
    
    func setUI() {
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        
        subtitleLabel.numberOfLines = 0
        subtitleLabel.font = .systemFont(ofSize: 13, weight: .regular)
        subtitleLabel.textColor = .lightGray
        subtitleLabel.textAlignment = .left
        
        dateLabel.numberOfLines = 0
        dateLabel.font = .systemFont(ofSize: 11, weight: .regular)
        dateLabel.textColor = .lightGray
        dateLabel.textAlignment = .right

        photoImage.contentMode = .scaleAspectFill
        photoImage.layer.cornerRadius = 10
        photoImage.clipsToBounds = true
    }
    
    func configureUI(row: Magazine, formatStringToDate: DateFormatter, formatDateToString: DateFormatter) {
        let url = URL(string: row.photo_image)
        photoImage.kf.setImage(with: url)
        
        titleLabel.text = row.title
        subtitleLabel.text = row.subtitle
        dateLabel.text = row.date
        
        let date = formatStringToDate.date(from: dateLabel.text ?? "") ?? Date()
        let dateString = formatDateToString.string(from: date)
        dateLabel.text = dateString
    }
}
