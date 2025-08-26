//
//  SelectTamagotchiViewModel.swift
//  TamagotchiGame
//
//  Created by 정성희 on 8/24/25.
//

import Foundation
import RxSwift
import RxCocoa

class SelectTamagotchiViewModel {
    
    var tamagotchiType: TamagotchiType
    
    struct Input {
        let cancelButtonTap: ControlEvent<Void>
        let startButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        let cancelButtonTap: PublishRelay<Void>
        let startButtonTap: PublishRelay<Void>
    }
    
    init(tamagotchiType: TamagotchiType) {
        self.tamagotchiType = tamagotchiType
    }
    
    private let disposeBag = DisposeBag()
    func transform(input: Input) -> Output {
        let cancelButtonTap: PublishRelay<Void> = PublishRelay()
        let startButtonTap: PublishRelay<Void> = PublishRelay()

        input.cancelButtonTap
            .bind {
                cancelButtonTap.accept(())
            }
            .disposed(by: disposeBag)
        
        input.startButtonTap
            .bind(with: self) { owner, _ in
                UserDefaultsManager.tamagotchiTypeIndex = owner.tamagotchiType.index
                
                if UserDefaultsManager.tamagotchiLevel == 0 {
                    UserDefaultsManager.tamagotchiLevel = 1
                }

                startButtonTap.accept(())
            }
            .disposed(by: disposeBag)
        
        return Output(cancelButtonTap: cancelButtonTap, startButtonTap: startButtonTap)
    }
}
