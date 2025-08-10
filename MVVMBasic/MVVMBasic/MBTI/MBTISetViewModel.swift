//
//  MBTISetViewModel.swift
//  MVVMBasic
//
//  Created by 정성희 on 8/11/25.
//

import Foundation

class MBTISetViewModel {
    // input - Parameter Signal
    var nickname: String? = "" {
        didSet {
            validateNickname()
        }
    }
    
    // input  - Method Signal
    
    // output
    var hintText: String = "" {
        didSet {
            fetchHintText?()
        }
    }
    
    // closure
    var fetchHintText : (() -> ())?
}

// MARK: - Logic
extension MBTISetViewModel {
    private func validateNickname() {
        guard let nickname = nickname else { return }

        guard nickname.count != 0 else {
            hintText = ""
            return
        }
        
        let (hasSpecial, specialChar) = isContainSpecialCharacter(text: nickname)
        guard !hasSpecial else {
            hintText = "닉네임에 \(specialChar ?? "")는 포함할 수 없어요."
            return
        }
        
        guard !isContainNumber(text: nickname) else {
            hintText = "닉네임에 숫자는 포함할 수 없어요."
            return
        }
        
        guard 2 <= nickname.count && nickname.count <= 9 else {
            hintText = "닉네임은 2글자 이상, 9글자 이하로 작성해주세요."
            return
        }

        hintText = "사용할 수 있는 닉네임이에요."
    }
    
    private func isContainSpecialCharacter(text: String) -> (Bool, String?) {
        let specialCharacterList = ["@", "#", "$", "%"]
        for char in specialCharacterList {
            if text.contains(char) {
                return (true, String(char))
            }
        }
        return (false, nil)
    }
    
    private func isContainNumber(text: String) -> Bool {
        for char in text {
            if Int(String(char)) != nil {
                return true
            }
        }
        return false
    }
}
