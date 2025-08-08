//
//  AgeViewModel.swift
//  MVVMBasic
//
//  Created by 정성희 on 8/8/25.
//

import Foundation

class AgeViewModel {
    // input
    var inputAge: String? = "" {
        didSet {
            validate()
        }
    }
    
    // output
    var outputResultLabel = "" {
        didSet {
            showResult?()
        }
    }
    
    // closure
    var showResult: (() -> ())?
    
    private var age = 0
    
    private func validate() {
        guard let inputAge = inputAge else { return }
        
        if checkIsValidInteger(text: inputAge) {
            checkIsValidRange(age: age)
        }
    }
    
    private func checkIsValidInteger(text: String) -> Bool {
        do {
            age = try ErrorManager.shared.validateUserInput(text: text, transferType: Int.self)
            return true
        } catch {
            switch error {
            case .EmptyString:    outputResultLabel = "값이 비어있습니다"
            case .haveWhiteSpace: outputResultLabel = "띄어쓰기를 포함할 수 없습니다"
            case .isNotInt:       outputResultLabel = "정수가 아닙니다"
            default:              outputResultLabel = "올바른 타입이 아닙니다"
            }
            return false
        }
    }
    
    private func checkIsValidRange(age: Int) {
        do {
            try ErrorManager.shared.validateNumberRange(value: age, min: 1, max: 100)
            outputResultLabel = "\(age)살 입니다"
        } catch {
            switch error {
            case .lowerTHanMinimum: outputResultLabel = "1살 이상의 값을 입력해주세요!"
            case .upperTHanMaximum: outputResultLabel = "100살 이하의 값을 입력해주세요!"
            }
        }
    }
}
