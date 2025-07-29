//
//  NetworkManager.swift
//  Shopping
//
//  Created by 정성희 on 7/29/25.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    private init() { }
    
    func callRequest(url: String, header: HTTPHeaders, sort: SortType = SortType.sim, success: @escaping (Shop) -> (), fail: @escaping (AFError) -> ()) { 
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Shop.self) { response in
                switch response.result {
                case .success(let value):
                    success(value)
                case .failure(let error):
                    fail(error)
                }
            }
    }
}
