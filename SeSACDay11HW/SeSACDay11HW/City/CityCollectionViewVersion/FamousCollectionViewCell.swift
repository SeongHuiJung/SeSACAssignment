//
//  FamousCollectionViewCell.swift
//  SeSACDay11HW
//
//  Created by 정성희 on 7/17/25.
//

import UIKit

class FamousCollectionViewCell: UICollectionViewCell {
    @IBOutlet var travelImage: UIImageView!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var cityExplainLabel: UILabel!
    
    static let identifier = "FamousCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureStandardUI()
    }
    
    func configureStandardUI() {
        travelImage.layer.cornerRadius = travelImage.frame.height / 1.75
        travelImage.clipsToBounds = true
        
        cityNameLabel.font = .systemFont(ofSize: 15)
        cityNameLabel.textColor = .black
        cityNameLabel.textAlignment = .center
        cityNameLabel.numberOfLines = 0
        
        cityExplainLabel.font = .systemFont(ofSize: 12)
        cityExplainLabel.textColor = .lightGray
        cityExplainLabel.textAlignment = .center
        cityExplainLabel.numberOfLines = 0
    }
    
    func configureUI(row: City) {
        travelImage.setDownSamplingImage(url: row.cityImage)
        cityNameLabel.text = "\(row.cityName) | \(row.cityEnglishName)"
        cityExplainLabel.text = row.cityExplain
    }
    
    func changeKeywordColor(label: UILabel, keyword: String) {
        guard let text = label.text else { return }
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttribute(.foregroundColor, value: UIColor.blue, range: (text.lowercased() as NSString).range(of: keyword))
        label.attributedText = attributeString
    }
}
