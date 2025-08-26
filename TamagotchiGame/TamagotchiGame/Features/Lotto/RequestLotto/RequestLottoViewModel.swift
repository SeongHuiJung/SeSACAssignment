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
            .filter { Int($0) != nil }
            .flatMap {
                let param = LottoParameter(method: "getLottoNumber", drwNo: $0)
                let router = NetworkRouter.lotto(param: param)
                return NetworkManager.callRequest(router: router, type: Lotto.self)
            }
            .bind(with: self) { owner, response in
                switch response {
                case .success(let data):
                    lottoList.accept(data.numList)
                case .failure(let error):
                    alertData.accept(("통신 에러", "에러가 발생했어요. 다시 시도해주세요."))
                }
            }
            .disposed(by: disposeBag)

        return Output(lottoList: lottoList, alertData: alertData)
    }
}

