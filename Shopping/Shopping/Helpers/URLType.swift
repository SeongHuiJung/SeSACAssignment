//
//  URLType.swift
//  Shopping
//
//  Created by 정성희 on 7/27/25.
//

import Foundation

enum URLType{
    case naverShop(params: [String: String])
    
    var url: String {
        switch self {
        case .naverShop(let params):
            var result = "?"
            for (key,value) in params {
                result += "\(key)=\(value)&"
            }
            result.popLast()
            result = Host.naverShop.rawValue + Path.naverShop.rawValue + result
            return result
        }
    }
}

enum Host: String {
    case naverShop = "https://openapi.naver.com"
}

enum Path: String {
    case naverShop = "/v1/search/shop.json"
}

enum SortType: String {
    case sim
    case date
    case asc
    case dsc
}
