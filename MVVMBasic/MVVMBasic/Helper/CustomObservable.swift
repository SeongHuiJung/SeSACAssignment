//
//  CustomObservable.swift
//  MVVMBasic
//
//  Created by 정성희 on 8/11/25.
//

import Foundation

class CustomObservable<T> {
    // 데이터가 변하면 실행될 메서드
    private var action: (() -> ())?
    
    // 데이터
    var value: T {
        didSet {
            action?()
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    // 한번만 수행
    // 호출하여 사용시 기존 didSet 내부 코드와 동일
    func bind(closure: @escaping () -> ()) {
        closure()
        self.action = closure
    }
}
