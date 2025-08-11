//
//  BMIViewModel.swift
//  MVVMBasic
//
//  Created by 정성희 on 8/8/25.
//

import Foundation

class BMIViewModel {

    // input - Parameter Signal
    var inputHeight: String? = ""
    var inputWeight: String? = ""
    
    // input  - Method Signal
    var calculateBMISignal = CustomObservable(())
    
    init() {
        calculateBMISignal.bind { [self] in
            guard let inputHeight else { return }
            height = validate(text: inputHeight, type: .height, min: 10, max: 200)
            
            guard height != nil, let inputWeight else { return }
            weight = validate(text: inputWeight, type: .weight, min: 5, max: 150)
            
            guard let height, let weight else { return }
            outputResultLabel.value = "BMI: \(String(calculateBMI(height: height, weight: weight)))"
        }
    }
    
    // output
    var outputResultLabel = CustomObservable("")
    var errorMessage = CustomObservable("")
    
    private var height: Double?
    private var weight: Double?
}

// MARK: - logic
extension BMIViewModel {
    private func validate(text: String, type: InfoType, min: Double, max: Double) -> Double? {
        let result = checkIsValiDouble(text: text, type: type)
        let isDouble = result.0
        let height = result.1
        
        if isDouble {
            return checkIsValidRangeAndReturn(value: height, min: min, max: max, type: type)
        }
        return nil
    }
    
    private func calculateBMI(height: Double, weight: Double) -> Double {
        let heightMeter = height * 0.01
        let bmi = weight / ( heightMeter * heightMeter )
        return Double(Int(bmi * 10)) / 10.0
    }
    
    private func checkIsValiDouble(text: String, type: InfoType) -> (Bool, Double) {
        do {
            let value = try ErrorManager.shared.validateUserInput(text: text, transferType: Double.self)
            return (true, value)
        } catch {
            switch error {
            case .EmptyString:    errorMessage.value = "\(type.rawValue) 값이 비어 있습니다"
            case .haveWhiteSpace: errorMessage.value = "\(type.rawValue) 값에 띄어쓰기를 포함할 수 없습니다"
            case .isNotDouble:    errorMessage.value = "입력한 \(type.rawValue) 값이 double이 아닙니다"
            default:              errorMessage.value = "입력한 \(type.rawValue) 값이 올바른 타입이 아닙니다"
            }
            return (false, 0)
        }
    }
    
    private func checkIsValidRangeAndReturn(value: Double, min: Double, max: Double, type: InfoType) -> Double? {
        do {
            try ErrorManager.shared.validateNumberRange(value: value, min: min, max: max)
            return value
        } catch {
            switch error {
            case .lowerTHanMinimum: errorMessage.value = "\(type.rawValue)는 \(min)\(type.unit) 이상으로 입력해주세요!"
            case .upperTHanMaximum: errorMessage.value = "\(type.rawValue)는 \(max)\(type.unit) 이하로 입력해주세요!"
            }
            return nil
        }
    }
}
