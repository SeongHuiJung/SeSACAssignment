//
//  CurrencyViewModel.swift
//  MVVMBasic
//
//  Created by 정성희 on 8/8/25.
//

import Foundation

class CurrencyViewModel {
    var inputMoney: String? = "" {
        didSet {
            validate()
        }
    }
    
    var outputMoney: String = "" {
        didSet {
            exchangeMoney?()
        }
    }
    
    var exchangeMoney: (() -> ())?
    
    private func validate() {
        guard let amountText = inputMoney,
              let amount = Double(amountText) else {
            outputMoney = "올바른 금액을 입력해주세요"
            return
        }
        exchangeMoeny(amount: amount)
    }
    
    private func exchangeMoeny(amount: Double) {
        let exchangeRate = 1350.0 // 실제 환율 데이터로 대체 필요
        let convertedAmount = amount / exchangeRate
        outputMoney = String(format: "%.2f USD (약 $%.2f)", convertedAmount, convertedAmount)
    }
}
