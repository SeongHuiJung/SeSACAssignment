//
//  NetworkRouter.swift
//  Shopping
//
//  Created by 정성희 on 8/13/25.
//

import Foundation
import Alamofire

// URLRequestConvertible
struct ShopParameter {
    var query: String
    var display: String
    var sort: String
    var start: String
}

enum ShoppingRouter {
    case searchProduct(
        params: ShopParameter
    )
    
    private var baseURL: String {
        switch self {
        case .searchProduct: return BaseURL.naverBaseURL
        }
    }
    
    var endPoint: String {
        switch self {
        case .searchProduct: return baseURL + EndPoint.naverShopSearch
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .searchProduct: return .get
        }
    }
    
    var parameter: Parameters {
        switch self {
        case .searchProduct(let params):
            return [
                "query" : params.query,
                "display" : params.display,
                "sort" : params.sort,
                "start" : params.start
            ]
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .searchProduct:
            return [
                "X-Naver-Client-Id" : APIKey.naverClientId,
                "X-Naver-Client-Secret" : APIKey.naverClientSecret
            ]
        }
    }
}
