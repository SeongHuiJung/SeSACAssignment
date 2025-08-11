//
//  WordCounterViewModel.swift
//  MVVMBasic
//
//  Created by 정성희 on 8/8/25.
//

import Foundation

class WordCounterViewModel {
    var inputText = CustomObservable("")
    var outputText = CustomObservable("")
    
    init() {
        inputText.bind {
            self.updateCharacterCount()
        }
    }
    
    private func updateCharacterCount() {
        let count = inputText.value.count
        outputText.value = "현재까지 \(count)글자 작성중"
    }
}
