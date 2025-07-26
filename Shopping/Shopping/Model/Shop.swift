//
//  Shop.swift
//  Shopping
//
//  Created by 정성희 on 7/25/25.
//

import Foundation

struct Shop: Codable {
    let items: [item]
}

struct item: Codable {
    let title: String
    let image: String
    let link: String
    let lprice: String
    let brand: String
    let productId: String
}
