//
//  BirthDayModel.swift
//  MVVMBasic
//
//  Created by 정성희 on 8/9/25.
//

import Foundation
enum DateType: String, CaseIterable {
    case year
    case month
    case day
    
    var unit: String {
        switch self {
        case .year: "년"
        case .month: "월"
        case .day: "일"
        }
    }
}
