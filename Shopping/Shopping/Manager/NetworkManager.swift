//
//  NetworkManager.swift
//  Shopping
//
//  Created by 정성희 on 7/29/25.
//

import Foundation
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    private init() { }
    
    // retry
    // 로딩화면
    func callRequest(url: String, header: HTTPHeaders, sort: SortType = SortType.sim, success: @escaping (Shop) -> (), fail: @escaping (ErrorType) -> ()) {
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Shop.self) { response in
                switch response.result {
                case .success(let value):
                    success(value)
                case .failure:
                    fail(self.getErrorType(response: response))
                }
            }
    }
    
    private func getErrorType(response: DataResponse<Shop, AFError>) -> ErrorType {
        let data = response.data
        guard let data = data else { return CommonErrorType.decodingError}

        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(APIError.self, from: data)
            var errorCode = result.errorCode
            
            // Naver Search API Error
            if errorCode.contains("SE") {
                errorCode.removeFirst(2)
                let errorType = NaverSearchErrorType(value: Int(errorCode) ?? 0)
               return errorType
            }
            
            // Naver Common API Error
            else {
                let responseCode = response.response?.statusCode ?? 1001
                return CommonErrorType(value: responseCode)
            }
        } catch {
            return CommonErrorType.decodingError
        }
    }
}
