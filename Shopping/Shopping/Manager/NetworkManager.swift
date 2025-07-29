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
        guard let data = data else { return ErrorType.decodingError }

        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(APIError.self, from: data)
            var errorCode = result.errorCode
            
            if errorCode.contains("SE") {
                errorCode.removeLast(2)
                return ErrorType.errorCode(num: Int(errorCode)!)
            }
            else {
                let responseCode = response.response?.statusCode
                return ErrorType.statusCode(num: responseCode!)
            }
        } catch {
            return ErrorType.decodingError
        }
    }
}
