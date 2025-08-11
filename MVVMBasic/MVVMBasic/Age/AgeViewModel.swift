//
//  AgeViewModel.swift
//  MVVMBasic
//
//  Created by 정성희 on 8/8/25.
//

import Foundation

class AgeViewModel {
    // input validate
    var inputAge = CustomObservable("")
    
    // output
    var outputResultLabel = CustomObservable("")
    
    private var age = 0
    
    init() {
        inputAge.bind { _ in
            self.validate()
        }
    }
    
    private func validate() {
        if checkIsValidInteger(text: inputAge.value) {
            checkIsValidRange(age: age)
        }
    }
    
    private func checkIsValidInteger(text: String) -> Bool {
        do {
            age = try ErrorManager.shared.validateUserInput(text: text, transferType: Int.self)
            return true
        } catch {
            switch error {
            case .EmptyString:    outputResultLabel.value = "값이 비어있습니다"
            case .haveWhiteSpace: outputResultLabel.value = "띄어쓰기를 포함할 수 없습니다"
            case .isNotInt:       outputResultLabel.value = "정수가 아닙니다"
            default:              outputResultLabel.value = "올바른 타입이 아닙니다"
            }
            return false
        }
    }
    
    private func checkIsValidRange(age: Int) {
        do {
            try ErrorManager.shared.validateNumberRange(value: age, min: 1, max: 100)
            outputResultLabel.value = "\(age)살 입니다"
        } catch {
            switch error {
            case .lowerTHanMinimum: outputResultLabel.value = "1살 이상의 값을 입력해주세요!"
            case .upperTHanMaximum: outputResultLabel.value = "100살 이하의 값을 입력해주세요!"
            }
        }
    }
}
