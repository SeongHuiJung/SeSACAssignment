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

enum SortType: Int, CaseIterable {
    case sim = 0
    case date
    case dsc
    case asc


    var koreanName: String {
        switch self {
        case .sim: "정확도"
        case .date: "날짜순"
        case .dsc: "가격높은순"
        case .asc: "가격낮은순"
        }
    }
    
    var englishName: String {
        switch self {
        case .sim: "sim"
        case .date: "date"
        case .dsc: "dsc"
        case .asc: "asc"
        }
    }
}

// 에러 타입을 보편적으로 사용하는 것과
// 특정 서비스에서만 사용될 수 있는 에러로 분리하자

enum NaverSearchErrorType: ErrorType {
    case invalidQueryRequest
    case invalidDisplayValue
    case invalidStartValue
    case invalidSortValue
    case malformedEncoding
    case invalidSearchApi
    case systemError
    
    var value: Int {
        switch self {
        case .invalidQueryRequest: 1
        case .invalidDisplayValue: 2
        case .invalidStartValue: 3
        case .invalidSortValue: 4
        case .malformedEncoding: 5
        case .invalidSearchApi: 6
        case .systemError: 99
        }
    }

    init(value: Int) {
        switch value {
        case 1: self = .invalidQueryRequest
        case 2: self = .invalidDisplayValue
        case 3: self = .invalidStartValue
        case 4: self = .invalidSortValue
        case 5: self = .malformedEncoding
        case 6: self = .invalidSearchApi
        default: self = .systemError
        }
    }
}

enum CommonErrorType: ErrorType {
    case invalidParameter
    case authenticationFail
    case rejectRequest
    case invalidURL
    case incorrectHTTPMethod
    case limitExceeded
    case severError
    case decodingError 
    case unknownError
    
    var value: Int {
        switch self {
        case .invalidParameter: 400
        case .authenticationFail: 401
        case .rejectRequest: 403
        case .invalidURL: 404
        case .incorrectHTTPMethod: 405
        case .limitExceeded: 429
        case .severError: 500
        case .decodingError: 1000
        case .unknownError: 1001
        }
    }
    
    init(value: Int) {
        switch value {
        case 400: self = .invalidParameter
        case 404: self = .invalidURL
        case 401: self = .authenticationFail
        case 403: self = .rejectRequest
        case 405: self = .incorrectHTTPMethod
        case 429: self = .limitExceeded
        case 500: self = .severError
        case 1000: self = .decodingError
        default: self = .unknownError
        }
    }
}

protocol ErrorType {}

