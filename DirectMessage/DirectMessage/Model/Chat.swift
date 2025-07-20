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
    let format = DateFormatter()
    
    var getDateDivisionFormattedString: String? {
        format.locale = Locale(identifier: "ko_KR")
        format.dateFormat = "yyyy-MM-dd HH:mm"
        let date = format.date(from: date)
        guard let date = date else { return nil }
        
        format.dateFormat = "yyyy-MM-dd"
        let result = format.string(from: date)
        
        return result
    }
    
    var getFormattedDateString: String? {
        format.locale = Locale(identifier: "ko_KR")
        
        format.dateFormat = "yyyy-MM-dd HH:mm"
        let date = format.date(from: date)
        guard let date = date else { return nil }
        
        format.dateFormat = "hh:mm a"
        let result = format.string(from: date)
        
        return result
    }
}
