//
//  UIImage+Extension.swift
//  SeSACDay11HW
//
//  Created by 정성희 on 7/16/25.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setDownSamplingImage(url: String?) {
        if let url = URL(string: url ?? "") {
            // Down Sampling
            let processor = DownsamplingImageProcessor(size: self.bounds.size)
            self.kf.setImage(with: url,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage, // 캐시가 있으면 캐시를 불러오고, 캐시가 없다면 네트워킹으로 데이터를 새로 받아옴
                .memoryCacheExpiration(.days(1)), // 메모리 캐시 유지 기간을 1일로 설정
                .diskCacheExpiration(.never) // 디스크 캐시는 만료되지 않도록 설정
            ])
        }
        else {
            self.image = UIImage(systemName: "xmark.diamond.fill")
        }
    }
}

