//
//  UIViewController+Extension.swift
//  Shopping
//
//  Created by 정성희 on 7/29/25.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, ok: String, errorType: ErrorType) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: ok, style: .default)
        alert.addAction(ok)

        self.present(alert, animated: true)
    }
    
    func showErrorAlert(errorType: ErrorType) {
        
        var message = ""
        
        switch errorType {
        case is NaverSearchErrorType:
            let error = errorType as! NaverSearchErrorType
            
            switch error {
            case .invalidQueryRequest : message = "잘못된 쿼리요청 이에요"
            case .invalidDisplayValue : message = "부적절한 display 값이에요"
            case .invalidStartValue : message = "부적절한 start 값이에요"
            case .invalidSortValue : message = "부적절한 sort 값이에요"
            case .malformedEncoding : message = "존재하지 않는 검색 api 이에요"
            case .invalidSearchApi : message = "잘못된 형식의 인코딩이에요"
            case .systemError : message = "알 수 없는 시스템 에러가 발생했어요"
            }

        case is CommonErrorType:
            let error = errorType as! CommonErrorType
            
            switch error {
            case .invalidParameter: message = "요청 변수를 확인해 주세요"
            case .authenticationFail: message = "인증을 실패했습니다"
            case .rejectRequest: message = "서버가 허용하지 않는 호출값 입니다"
            case .invalidURL: message = "API 요청 URL이 잘못되었습니다"
            case .incorrectHTTPMethod: message = "잘못된 HTTP 메서드를 호출했어요"
            case .limitExceeded: message = "Request 요청 회수를 초과했어요"
            case .severError: message = "서버에 오류가 발생했어요"
            case .decodingError: message = "디코딩 에러가 발생했어요"
            case .unknownError: message = "알 수 없는 에러가 발생했어요"
            }
        default: print("알 수 없는 에러")
        }
        
        let alert = UIAlertController(title: "Error !", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(ok)

        self.present(alert, animated: true)
    }
}
