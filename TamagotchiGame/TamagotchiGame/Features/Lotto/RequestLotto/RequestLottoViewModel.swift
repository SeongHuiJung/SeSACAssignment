//
//  RequestLottoViewModel.swift
//  TamagotchiGame
//
//  Created by 정성희 on 8/25/25.
//

import Foundation
import RxSwift
import RxCocoa

final class RequestLottoViewModel {
    struct Input {
        let textFieldReturnTapped: Observable<ControlProperty<String>.Element>
    }
    
    struct Output {
        let lottoList: PublishRelay<[Int]>
        let alertData: PublishRelay<(title: String, message: String)>
    }
    
    init() {}
    
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        
        let lottoList: PublishRelay<[Int]> = PublishRelay()
        let alertData: PublishRelay<(title: String, message: String)> = PublishRelay()
        
        input.textFieldReturnTapped
            .distinctUntilChanged()
            .filter {
                if Int($0) != nil {
                    return true
                }
                else {
                    alertData.accept((ErrorType.incorrectDecoding.title, ErrorType.incorrectDecoding.message))
                    return false
                }
            }
            .flatMap {
                let param = LottoParameter(method: "getLottoNumber", drwNo: $0)
                let router = NetworkRouter.lotto(param: param)
                return NetworkManager.callRequestWithResultType(router: router, type: Lotto.self)
            }
            .bind{ response in
                switch response {
                case .success(let data):
                    lottoList.accept(data.numList)
                case .failure(let error):
                    
                    var errorType = ErrorType.unknown
                    
                    if let afError = error.asAFError,
                       let urlError = afError.underlyingError as? URLError {
                        switch urlError.code {
                        case .notConnectedToInternet:
                            errorType = .notConnectedToInternet
                        case .cannotFindHost, .cannotConnectToHost:
                            errorType = .serverError
                        default:
                            errorType = .incorrectDecoding
                        }
                    } else {
                        errorType = .unknown
                    }
                    
                    alertData.accept((errorType.title, errorType.message))
                }
            }
            .disposed(by: disposeBag)
        
        return Output(lottoList: lottoList, alertData: alertData)
    }
}
