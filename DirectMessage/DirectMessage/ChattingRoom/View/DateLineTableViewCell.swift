//
//  DateLineTableViewCell.swift
//  DirectMessage
//
//  Created by 정성희 on 7/20/25.
//

import UIKit

class DateLineTableViewCell: UITableViewCell {

    static let identifier = "DateLineTableViewCell"
    
    @IBOutlet var dateView: UIView!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    private func configure() {
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .white
        dateLabel.textAlignment = .center
        
        dateView.layer.cornerRadius = 10
        dateView.clipsToBounds = true
        dateView.backgroundColor = .systemGray2
    }
    
    func configureData(text: String) {
        dateLabel.text = text
    }
}
