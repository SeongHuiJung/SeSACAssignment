//
//  Chat.swift
//  SeSAC7Step1Remind
//
//  Created by Jack on 7/18/25.
//

import Foundation
//채팅 화면에서 사용할 데이터 구조체
struct Chat {
    let user: User
    let date: String
    let message: String
    
    var getDateDivisionFormattedString: String? {
        let date = DateFormatter.formatStringToDate(dateText: date, format: "yyyy-MM-dd HH:mm")
        
        guard let date = date else { return nil }
        
        let result = DateFormatter.formatDateToString(date: date, format: "yyyy-MM-dd")
    
        return result
    }
    
    var getFormattedDateString: String? {
        let date = DateFormatter.formatStringToDate(dateText: date, format: "yyyy-MM-dd HH:mm")
        
        guard let date = date else { return nil }
        
        let result = DateFormatter.formatDateToString(date: date, format: "hh:mm a")
        
        return result
    }
}
