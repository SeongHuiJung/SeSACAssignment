//
//  NumberViewModel.swift
//  RxSwiftStudy
//
//  Created by 정성희 on 8/21/25.
//

import Foundation
import RxSwift
import RxCocoa

class NumberViewModel {
    struct Input {
        var valueChaged: Observable<(ControlProperty<String>.Element, ControlProperty<String>.Element, ControlProperty<String>.Element)>
    }
    
    struct Output {
        var resultValue: BehaviorRelay<String>
    }
    
    private let disposeBag = DisposeBag()
    
    init() {}
    
    func transform(input: Input) -> Output {
        
        let result = BehaviorRelay(value: "")
        
        input.valueChaged
            .map { valueList in
                String((Int(valueList.0) ?? 0) + (Int(valueList.1) ?? 0) + (Int(valueList.2) ?? 0))
            }
            .distinctUntilChanged()
            .bind(with: self) { owner, resultValue in
                result.accept(String(resultValue))
            }
            .disposed(by: disposeBag)
        return Output(resultValue: result)
    }
}
