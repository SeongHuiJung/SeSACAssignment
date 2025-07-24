//
//  Movie.swift
//  SeSAC7Week4Codebase
//
//  Created by Jack on 7/23/25.
//

import Foundation

struct Movie {
    let title: String
    let releaseDate: String
    let rank : Int
        
    var getFormattedDateString: String {
        let date = DateFormatter.formatStringToDate(dateText: releaseDate, format: "yyyyMMdd")
        guard let date = date else { return "" }
        return DateFormatter.formatDateToString(date: date, format: "yyyy-MM-dd")
    }
}
