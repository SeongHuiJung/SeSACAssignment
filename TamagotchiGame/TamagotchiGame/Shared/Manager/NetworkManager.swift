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
    static func callRequest<T>(url: String, type: T.Type) -> Observable<T> {
        return Observable<T>.create { observer in
            AF.request(url).responseDecodable(of: Lotto.self) { response in
                switch response.result {
                case .success(let value):
                    observer.onNext(value as! T) // 성공시 데이터 던지기
                    observer.onCompleted() // 작업 완료 후에 반드시 메모리 해제
                case .failure(let error):
                    observer.onError(CommonError.invalid) // 실패시 오류 던지기
                }
            }
            return Disposables.create()
        }
    }
}
