//
//  ChatRoom.swift
//  SeSAC7Step1Remind
//
//  Created by Jack on 7/18/25.
//

import Foundation

//트래블톡 화면에서 사용할 데이터 구조체
struct ChatRoom {
    let chatroomId: Int //채팅방 고유 ID
    let chatroomImage: String //채팅방 이미지
    let chatroomName: String //채팅방 이름
    var chatList: [Chat] = [] //채팅 화면에서 사용할 데이터
    
    var getLastChatText: String? {
        return self.chatList.last?.message
    }
    
    var getLastChatDate: String? {
        let dateText = self.chatList.last?.date
        guard let dateText = dateText else { return nil }
    
        let date = DateFormatter.formatStringToDate(dateText: dateText, format: "yyyy-MM-dd HH:mm")
        
        guard let date = date else { return nil }
        
        let result = DateFormatter.formatDateToString(date: date, format: "yy.MM.dd")
        
        return result
    }
}
