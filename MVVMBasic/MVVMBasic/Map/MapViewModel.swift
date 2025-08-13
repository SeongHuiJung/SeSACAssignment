//
//  MapViewModel.swift
//  MVVMBasic
//
//  Created by 정성희 on 8/11/25.
//

import Foundation
import UIKit

class MapViewModel {
    // input - Parameter Signal
    var inputFoodType = Observable(FoodType.all)
    
    // output
    var outputFoodList: Observable<[Restaurant]> = Observable([])
    
    // 각각의 탭 로드하지 않아도 바로 init 됨
    // 지도 뷰 뜨자마자 바로 모든 지점 뜨도록 bind 에 isfirstExecute을 true로 전달
    init() {
        inputFoodType.lazyBind { _ in
            self.outputFoodList.value = self.getFoodListForType()
        }
    }
    
    private func getFoodListForType() -> [Restaurant] {
        var result = [Restaurant]()
        let foodType = inputFoodType.value.rawValue
        if foodType == FoodType.all.rawValue {
            result = RestaurantList.restaurantArray
        }
        else {
            for item in RestaurantList.restaurantArray {
                if item.category == inputFoodType.value.rawValue {
                    result.append(item)
                }
            }
        }

        return result
    }
}
