//
//  TamagotchiViewModel.swift
//  SeSACDay8HW
//
//  Created by 정성희 on 8/23/25.
//

import Foundation
import RxSwift
import RxCocoa

final class TamagotchiViewModel {
    struct Input {
        let riceButtonTapped: ControlEvent<Void>
        let addRiceAmount: ControlProperty<String>
        
        let waterButtonTapped: ControlEvent<Void>
        let addWaterAmount: ControlProperty<String>
    }
    
    struct Output {
        let statusResult: BehaviorRelay<String>
    }
    
    init() {}
    
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        let statusResult: BehaviorRelay<String> = BehaviorRelay(value: getUpdateStatusText())

        input.riceButtonTapped
            .withLatestFrom(input.addRiceAmount)
            .bind(with: self) { owner, addRiceAmount in
                if addRiceAmount == "" {
                    UserDefaultsManager.riceCount += 1
                    statusResult.accept(owner.getUpdateStatusText())
                }
                else if let addRiceAmount = Int(addRiceAmount) {
                    if addRiceAmount < 100 {
                        UserDefaultsManager.riceCount += addRiceAmount
                        statusResult.accept(owner.getUpdateStatusText())
                    }
                }
            }
            .disposed(by: disposeBag)
        
        input.waterButtonTapped
            .withLatestFrom(input.addWaterAmount)
            .bind(with: self) { owner, addWaterAmount in
                if addWaterAmount == "" {
                    UserDefaultsManager.waterCount += 1
                    statusResult.accept(owner.getUpdateStatusText())
                }
                else if let addWaterAmount = Int(addWaterAmount) {
                    if addWaterAmount < 50 {
                        UserDefaultsManager.waterCount += addWaterAmount
                        statusResult.accept(owner.getUpdateStatusText())
                    }
                }
            }
            .disposed(by: disposeBag)

        return Output(statusResult: statusResult)
    }
    
    private func getUpdatedLevel(riceCount: Int, waterCount: Int) -> Int {
        let level = Int((Double(riceCount) / 5 + Double(waterCount) / 2) / 10) + 1
        if level > 10 { return 10 }
        return level
    }
    
    private func getUpdateStatusText() -> String {
        let riceCount = UserDefaultsManager.riceCount
        let waterCount = UserDefaultsManager.waterCount
        let level = getUpdatedLevel(riceCount: riceCount, waterCount: waterCount)
        return "LV.\(level) · 밥알\(riceCount)개 · 물방울 \(waterCount)개"
    }
}
