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
    
    static let identifier = "TravelCityTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()

        cityNameLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        cityNameLabel.textColor = .white
        cityNameLabel.textAlignment = .right
        
        cityExplainLabel.font = .systemFont(ofSize: 13)
        cityExplainLabel.textColor = .white
        cityExplainLabel.textAlignment = .left
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
}
