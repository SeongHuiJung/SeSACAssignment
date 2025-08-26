//
//  ErrorType.swift
//  TamagotchiGame
//
//  Created by 정성희 on 8/27/25.
//

import Foundation

enum ErrorType {
    case notConnectedToInternet
    case incorrectDecoding
    case serverError
    case unknown
    
    var title: String {
        switch self {
        case .notConnectedToInternet: "네트워크 오류"
        case .incorrectDecoding: "입력 오류"
        case .serverError: "서버 오류"
        case .unknown: "오류"
        }
    }
    
    var message: String {
        switch self {
        case .notConnectedToInternet: "네트워크 연결을 확인해주세요"
        case .incorrectDecoding: "잘못된 입력값이에요"
        case .serverError: "서버에 오류가 발생했어요"
        case .unknown: "알 수 없는 오류입니다"
        }
    }
}
