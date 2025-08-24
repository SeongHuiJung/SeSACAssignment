//
//  UICollectionView+Extension.swift
//  SeSACDay8HW
//
//  Created by 정성희 on 8/23/25.
//

import UIKit

extension UICollectionView {
    static func getLayout(scrollDirection: UICollectionView.ScrollDirection, cellCount: CGFloat, gap: (minimumLineSpacing: CGFloat, minimumInteritemSpacing: CGFloat), edgeInsets: (horizontal: CGFloat, vertical: CGFloat), standardTotalSize: CGFloat, fixCellSize: CGFloat) -> UICollectionViewFlowLayout {
        var cellSize: Double = 0
        let layout = UICollectionViewFlowLayout()
        
        if scrollDirection == .horizontal {
            cellSize = (standardTotalSize - (gap.minimumInteritemSpacing * 2) - (gap.minimumInteritemSpacing * (cellCount - 1))) / cellCount
            layout.itemSize = CGSize(width: fixCellSize, height: cellSize)
            
        }
        else {
            cellSize = (standardTotalSize - (gap.minimumLineSpacing * 2) - (gap.minimumLineSpacing * (cellCount - 1))) / cellCount
            layout.itemSize = CGSize(width: cellSize, height: fixCellSize)
        }

        layout.sectionInset = UIEdgeInsets(top: edgeInsets.vertical, left: edgeInsets.horizontal, bottom: edgeInsets.vertical, right: edgeInsets.horizontal)
        layout.minimumLineSpacing = gap.minimumLineSpacing
        layout.minimumInteritemSpacing = gap.minimumInteritemSpacing
        layout.scrollDirection = scrollDirection
        
        return layout
    }
}
