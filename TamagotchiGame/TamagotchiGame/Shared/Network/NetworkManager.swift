//
//  NetworkManager.swift
//  TamagotchiGame
//
//  Created by 정성희 on 8/25/25.
//

import Foundation
import Alamofire
import RxSwift

enum CommonError: Error {
    case invalid
}

final class NetworkManager {
    static func callRequest<T: Decodable>(router: NetworkRouter, type: T.Type) -> Observable<Result<T, AFError>> {
        return Observable<Result<T, AFError>>.create { observer in
            AF.request(router.URL, method: router.method, parameters: router.parameter).responseDecodable(of: type) { response in
                switch response.result {
                case .success(let value):
                    observer.onNext(.success(value)) // 성공시 데이터 던지기
                    observer.onCompleted() // 작업 완료 후에 반드시 메모리 해제
                case .failure(let error):
                    observer.onNext(.failure(error)) // 성공시 데이터 던지기
                    observer.onCompleted() // 작업 완료 후에 반드시 메모리 해제
                }
            }
            return Disposables.create()
        }
    }
}
