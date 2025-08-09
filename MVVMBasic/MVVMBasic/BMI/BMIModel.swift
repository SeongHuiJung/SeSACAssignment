//
//  BMIModel.swift
//  MVVMBasic
//
//  Created by 정성희 on 8/9/25.
//

import Foundation

enum InfoType: String {
    case height = "키"
    case weight = "몸무게"
    
    var unit: String {
        switch self {
        case .height: "cm"
        case .weight: "kg"
        }
    }
}
