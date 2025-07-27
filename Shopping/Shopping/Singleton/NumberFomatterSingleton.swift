//
//  NumberFomatterSingleton.swift
//  Shopping
//
//  Created by 정성희 on 7/27/25.
//

import Foundation

class NumberFomatterSingleton {
    static let shared = NumberFomatterSingleton()
    
    let foarmatter: NumberFormatter
    
    private init() {
        foarmatter = NumberFormatter()
        foarmatter.numberStyle = .decimal
    }
}
