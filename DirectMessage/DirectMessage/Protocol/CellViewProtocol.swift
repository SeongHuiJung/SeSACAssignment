//
//  CellViewProtocol.swift
//  DirectMessage
//
//  Created by 정성희 on 7/22/25.
//

import Foundation

@objc protocol CellViewProtocol {
    func configure()
    @objc optional func configureData()
}
