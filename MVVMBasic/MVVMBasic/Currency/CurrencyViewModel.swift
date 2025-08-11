//
//  CurrencyViewModel.swift
//  MVVMBasic
//
//  Created by 정성희 on 8/8/25.
//

import Foundation

class CurrencyViewModel {
    var inputMoney = CustomObservable("")
    var outputMoney = CustomObservable("")

    init() {
        inputMoney.bind { _ in
            self.validate()
        }
    }
    
    private func validate() {
        guard let amount = Double(inputMoney.value) else {
            outputMoney.value = "올바른 금액을 입력해주세요"
            return
        }
        exchangeMoeny(amount: amount)
    }
    
    private func exchangeMoeny(amount: Double) {
        let exchangeRate = 1350.0 // 실제 환율 데이터로 대체 필요
        let convertedAmount = amount / exchangeRate
        outputMoney.value = String(format: "%.2f USD (약 $%.2f)", convertedAmount, convertedAmount)
    }
}
