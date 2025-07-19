//
//  UIViewController+Extension.swift
//  DirectMessage
//
//  Created by 정성희 on 7/19/25.
//

import UIKit

extension UIViewController {
    
    func setNib(identifier: String, object: UICollectionView) {
        let nib = UINib(nibName: identifier, bundle: nil)
        object.register(nib, forCellWithReuseIdentifier: identifier)
    }
    
    func setNib(identifier: String, object: UITableView) {
        let nib = UINib(nibName: identifier, bundle: nil)
        object.register(nib, forCellReuseIdentifier: identifier)
    }
    
}
