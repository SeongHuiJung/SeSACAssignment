//
//  Observable.swift
//  Shopping
//
//  Created by 정성희 on 8/12/25.
//

import Foundation

class Observable<T> {
    private var action: ((T) -> ())?
    
    var value: T {
        didSet {
            action?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(action: @escaping (T) -> ()) {
        action(value)
        self.action = action
    }
    
    func lazyBind(action: @escaping (T) -> ()) {
        self.action = action
    }
}
