//
//  TravelCityTableViewCell.swift
//  SeSACDay11HW
//
//  Created by 정성희 on 7/15/25.
//

import UIKit
import Kingfisher

class TravelCityTableViewCell: UITableViewCell {
    @IBOutlet var travelImage: UIImageView!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var cityExplainLabel: UILabel!
    @IBOutlet var labelBackgroundImage: UIView!
    @IBOutlet var shadowView: UIView!
    
    static let identifier = "TravelCityTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureStandardUI()
    }
    
    func configureStandardUI() {
        cityNameLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        cityNameLabel.textColor = .white
        cityNameLabel.textAlignment = .right
        
        cityExplainLabel.font = .systemFont(ofSize: 13)
        cityExplainLabel.textColor = .white
        cityExplainLabel.textAlignment = .left
        
        travelImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        travelImage.layer.cornerRadius = 12
        travelImage.layer.masksToBounds = true
        
        labelBackgroundImage.layer.maskedCorners = [.layerMaxXMaxYCorner]
        labelBackgroundImage.layer.cornerRadius = 12
        
        // 그림자 설정
        shadowView.backgroundColor = .white
        shadowView.layer.shadowOffset = CGSize(width: 5, height: 5)
        shadowView.layer.shadowOpacity = 0.2
        shadowView.layer.shadowRadius = 4
        shadowView.layer.cornerRadius = 12
        shadowView.layer.masksToBounds = false
    }

    func configureUI(row: City) {
        let url = URL(string: row.cityImage)
        let processor = DownsamplingImageProcessor(size: travelImage.bounds.size)
        travelImage.kf.setImage(with: url,
        options: [
            .processor(processor),
            .scaleFactor(UIScreen.main.scale),
            .cacheOriginalImage, // 캐시가 있으면 캐시를 불러오고, 캐시가 없다면 네트워킹으로 데이터를 새로 받아옴
            .memoryCacheExpiration(.days(1)), // 메모리 캐시 유지 기간을 1일로 설정
            .diskCacheExpiration(.never) // 디스크 캐시는 만료되지 않도록 설정
        ])
        
        cityNameLabel.text = "\(row.cityName) | \(row.cityEnglishName)"
        cityExplainLabel.text = row.cityExplain
    }
    
    // 검색한 키워드와 일치하는 글자 색 변경
    func changeKeywordColor(label: UILabel, keyword: String) {
        print("keyword: \(keyword)")
        guard let text = label.text else { return }
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttribute(.foregroundColor, value: UIColor.yellow, range: (text.lowercased() as NSString).range(of: keyword))
        label.attributedText = attributeString
    }
}
