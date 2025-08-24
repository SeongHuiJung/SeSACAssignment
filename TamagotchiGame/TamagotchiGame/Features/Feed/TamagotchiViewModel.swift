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
        let tamagotchiType: BehaviorRelay<TamagotchiType>
        
        let riceButtonTapped: ControlEvent<Void>
        let addRiceAmount: ControlProperty<String>
        
        let waterButtonTapped: ControlEvent<Void>
        let addWaterAmount: ControlProperty<String>
    }
    
    struct Output {
        let tamagotchiType: BehaviorRelay<TamagotchiType>
        let statusResult: BehaviorRelay<String>
        let tamagotchiMessage: BehaviorRelay<String>
        let tamagotchiImage: BehaviorRelay<String>
    }
    
    init() {}
    
    private let tamagotchiMessageList = TamagotchiData().messages
    
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        let statusResult: BehaviorRelay<String> = BehaviorRelay(value: getUpdateStatusText())
        let tamagotchiMessage: BehaviorRelay<String> = BehaviorRelay(value: tamagotchiMessageList.randomElement() ?? "")
        let tamagotchiType: BehaviorRelay<TamagotchiType> = BehaviorRelay(value: TamagotchiType.none)
        let tamagotchiImage: BehaviorRelay<String> = BehaviorRelay(value: "")
        
        input.riceButtonTapped
            .withLatestFrom(input.addRiceAmount)
            .bind(with: self) { owner, addRiceAmount in
                if addRiceAmount == "" || (Int(addRiceAmount) != nil && Int(addRiceAmount)! < 100) {
                    UserDefaultsManager.riceCount += Int(addRiceAmount) ?? 1
                    statusResult.accept(owner.getUpdateStatusText())
                    tamagotchiImage.accept("\(input.tamagotchiType.value.index)-\(owner.getLevel())")
                    
                    var message = owner.tamagotchiMessageList.randomElement() ?? ""
                    message = message.replacingOccurrences(of: "userName", with: UserDefaultsManager.userName)
                    tamagotchiMessage.accept(message)
                }
            }
            .disposed(by: disposeBag)
        
        input.waterButtonTapped
            .withLatestFrom(input.addWaterAmount)
            .bind(with: self) { owner, addWaterAmount in
                
                if addWaterAmount == "" || (Int(addWaterAmount) != nil && Int(addWaterAmount)! < 50) {
                    UserDefaultsManager.waterCount += Int(addWaterAmount) ?? 1
                    statusResult.accept(owner.getUpdateStatusText())
                    tamagotchiImage.accept("\(input.tamagotchiType.value.index)-\(owner.getLevel())")
                    
                    var message = owner.tamagotchiMessageList.randomElement() ?? ""
                    message = message.replacingOccurrences(of: "userName", with: UserDefaultsManager.userName)
                    tamagotchiMessage.accept(message)
                }
            }
            .disposed(by: disposeBag)

        input.tamagotchiType
            .bind(with: self) { owner, type in
                tamagotchiType.accept(type)
            }
            .disposed(by: disposeBag)
        
        return Output(tamagotchiType: tamagotchiType, statusResult: statusResult, tamagotchiMessage: tamagotchiMessage, tamagotchiImage: tamagotchiImage)
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
    
    private func getLevel() -> Int {
        let riceCount = UserDefaultsManager.riceCount
        let waterCount = UserDefaultsManager.waterCount
        let level = getUpdatedLevel(riceCount: riceCount, waterCount: waterCount)
        return level
    }
}
