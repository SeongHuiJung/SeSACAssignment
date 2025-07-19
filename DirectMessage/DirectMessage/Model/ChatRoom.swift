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
    
    private let format = DateFormatter()
    
    var getLastChatText: String? {
        return self.chatList.last?.message
    }
    
    var getLastChatDate: String? {
        let dateText = self.chatList.last?.date
        guard let dateText = dateText else { return nil }
        
        format.dateFormat = "yyyy-MM-dd HH:mm"
        let date = format.date(from: dateText)
        guard let date = date else { return nil }
    
        format.dateFormat = "yy.MM.dd"
        let result = format.string(from: date)
        
        return result
    }
}
