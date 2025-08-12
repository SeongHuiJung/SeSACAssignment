//
//  SearchViewModel.swift
//  Shopping
//
//  Created by 정성희 on 8/12/25.
//

import Foundation

class SearchViewModel {
    var inputSearchBarButtonTapped: Observable<String?> = Observable("")
    var inputSearchBarCancelButtonTapped = Observable(())
    
    var outputShowAlert: Observable<String> = Observable("")
    var outputPushNextVC: Observable<String> = Observable("")
    var outputSearchBarCancelButtonTapped = Observable(())
    
    init() {
        inputSearchBarButtonTapped.lazyBind { text in
            self.validate(text: text)
        }
        
        inputSearchBarCancelButtonTapped.bind {
            self.outputSearchBarCancelButtonTapped.value = ()
        }
    }
}

// MARK: - Logic
extension SearchViewModel {
    private func isHaveOnlyWhiteSpace(text: String) -> Bool {
        for char in text {
            if char != " " {
                return false
            }
        }
        return true
    }
    
    private func validate(text: String?) {

        guard let text else { return }
        
        guard !isHaveOnlyWhiteSpace(text: text) else {
            
            outputShowAlert.value = "검색어를 입력해 주세요" // TODO: enum 으로 refactoring
            return
        }
        
        guard text.count >= 2 else {
            outputShowAlert.value = "2글자 이상 입력해 주세요"
            return
        }
        
        outputPushNextVC.value = text
    }
}

