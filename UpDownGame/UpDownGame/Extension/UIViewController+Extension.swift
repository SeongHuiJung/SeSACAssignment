//
//  UIViewController+Extension.swift
//  UpDownGame
//
//  Created by 정성희 on 7/21/25.
//

import UIKit

extension UIViewController {
    
    func setNib(identifier: String, object: UICollectionView) {
        let nib = UINib(nibName: identifier, bundle: nil)
        object.register(nib, forCellWithReuseIdentifier: identifier)
    }
    
    func navigationPush(storyboard: String, identifier: String) {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as! UIViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
