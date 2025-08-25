//
//  RequestLottoViewModel.swift
//  TamagotchiGame
//
//  Created by 정성희 on 8/25/25.
//

import Foundation
import RxSwift
import RxCocoa

class RequestLottoViewModel {
    struct Input {
        let textFieldReturnTapped: Observable<ControlProperty<String>.Element>
    }
    
    struct Output {
        let lottoList: PublishRelay<[Int]>
    }
    
    init() {}
    
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        
        let lottoList: PublishRelay<[Int]> = PublishRelay()
        
        input.textFieldReturnTapped
            .distinctUntilChanged()
            .filter { Int($0) != nil }
            .flatMap {
                NetworkManager.callRequest(url: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\($0)", type: Lotto.self)
            }
            .subscribe(with: self) { owner, lottoData in
                lottoList.accept(lottoData.numList)
            } onError: { owner, error in
                print("onError", error)
            } onCompleted: { owner in
                print("onCompleted")
            } onDisposed: { owner in
                print("onDisposed")
            }
            .disposed(by: disposeBag)

        return Output(lottoList: lottoList)
    }
}

