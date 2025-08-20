//
//  UIImageView+Extension.swift
//  RxSwiftStudy
//
//  Created by 정성희 on 8/20/25.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setDownSamplingImage(url: String?) {
        if let url = URL(string: url ?? "") {
            let processor = DownsamplingImageProcessor(size: self.bounds.size)
            self.kf.setImage(with: url, options: [.processor(processor)])
        }
        else {
            self.image = UIImage(systemName: "xmark")
        }
    }
}
