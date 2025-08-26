//
//  DateFormatter+Extension.swift
//  TamagotchiGame
//
//  Created by 정성희 on 8/27/25.
//

import Foundation

extension DateFormatter {
    static func formatDateToString(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    static func formatStringToDate(dateText: String, format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = format
        return formatter.date(from: dateText)
    }
}
