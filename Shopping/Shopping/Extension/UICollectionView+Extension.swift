//
//  UICollectionView+Extension.swift
//  Shopping
//
//  Created by 정성희 on 7/27/25.
//

import UIKit

extension UICollectionView {
    static func getLayoutVertical(cellCount: CGFloat, gap: CGFloat) -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let deviceWidth = UIScreen.main.bounds.width

        let cellWidth: Double = deviceWidth - (gap * 2) - (gap * (cellCount - 1))
        layout.itemSize = CGSize(width: cellWidth / cellCount, height: 270)
        layout.sectionInset = UIEdgeInsets(top: gap, left: gap, bottom: gap, right: gap)
        layout.minimumLineSpacing = gap
        layout.minimumInteritemSpacing = gap
        layout.scrollDirection = .vertical
        
        return layout
    }
    
    static func getLayoutHorizontal(cellCount: CGFloat, gap: CGFloat) -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 32)
        layout.sectionInset = UIEdgeInsets(top: gap, left: gap, bottom: gap, right: gap)
        layout.minimumLineSpacing = gap
        layout.minimumInteritemSpacing = gap
        layout.scrollDirection = .horizontal
        
        return layout
    }
}
