//
//  URLType.swift
//  Shopping
//
//  Created by 정성희 on 7/27/25.
//

import Foundation

// 라우터패턴 적용
// 중첩 enum
// struct 로 parmas 넘겨줄 수 있지 않을까?
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

enum ErrorType {
    case errorCode(num: Int)
    case statusCode(num: Int)
    case decodingError
}
