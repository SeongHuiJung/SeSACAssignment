//
//  UIImageView+Extension.swift
//  Shopping
//
//  Created by 정성희 on 7/27/25.
//

import UIKit
import Kingfisher

extension UIImageView {
    // Down Sampling
    func setDownSamplingImage(url: String?) {
        if let url = URL(string: url ?? "") {
            let processor = DownsamplingImageProcessor(size: self.bounds.size)
            self.kf.setImage(with: url,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage,
                .memoryCacheExpiration(.days(1)),
                .diskCacheExpiration(.never)
            ])
        }
        else {
            self.image = UIImage(systemName: "xmark.diamond.fill")
        }
    }
}
