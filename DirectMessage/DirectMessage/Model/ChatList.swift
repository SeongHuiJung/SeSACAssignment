//
//  ChatList.swift
//  SeSAC7Step1Remind
//
//  Created by Jack on 7/18/25.
//

import Foundation

struct ChatList {
    
    static let me = User(name: "김새싹", image: "Me")
    static let hue = User(name: "Hue", image: "Hue")
    static let bran = User(name: "Bran", image: "Bran")
    static let jack = User(name: "Jack", image: "Jack")
    static let den = User(name: "Den", image: "Den")
    static let finn = User(name: "Finn", image: "Finn")
    static let other_friend = User(name: "Other Friend", image: "Other")
    static let simsim = User(name: "심심이", image: "Simsim")
    
    static func getBubbleType(preCell: Chat) -> (BubbleType, BubbleType) {
        if preCell.bubbleType == BubbleType.allData {
            return (BubbleType.sequenceFirst, BubbleType.sequenceLast)
        }
        else if preCell.bubbleType == BubbleType.sequenceLast {
            return (BubbleType.sequenceMiddle, BubbleType.sequenceLast)
        }
        else {
            return (BubbleType.sequenceMiddle, BubbleType.sequenceLast)
        }
    }
    
    static func setAllBubbleType() {
        for i in 0..<ChatList.list.count {
            for j in 0..<ChatList.list[i].chatList.count {
                let senderName = ChatList.list[i].chatList[j].user.name
                
                switch senderName {
                case ChatList.me.name:
                    ChatList.list[i].chatList[j].bubbleType = .me
                default:
                    // 첫 번째 디엠이 상대방이라면 무조건 all Data
                    if j == 0 {
                        ChatList.list[i].chatList[j].bubbleType = BubbleType.allData
                    }
                    
                    else {
                        let preCell = ChatList.list[i].chatList[j - 1]
                        let currentCell = ChatList.list[i].chatList[j]
                        
                        // 연속된 유저인지 확인 후 분기처리
                        // 동일한 이름이라면
                        if preCell.user.name == currentCell.user.name {
                            
                            // 시간이 같은 경우에
                            if preCell.date == currentCell.date {
                                let preAndCurrentBubbleType = getBubbleType(preCell: preCell)
                                let preCellBubbleType = preAndCurrentBubbleType.0
                                let currentCellBubbleType = preAndCurrentBubbleType.1
                                
                                ChatList.list[i].chatList[j - 1].bubbleType = preCellBubbleType
                                ChatList.list[i].chatList[j].bubbleType = currentCellBubbleType
                            }
                            
                            // 시간이 다르면 무조건 all Data
                            else {
                                ChatList.list[i].chatList[j].bubbleType = BubbleType.allData
                            }
                        }
                        
                        // 다른 이름이라면 무조건 all Data
                        else {
                            ChatList.list[i].chatList[j].bubbleType = BubbleType.allData
                        }
                    }
                }
            }
        }
    }
    
    static var list: [ChatRoom] = [
        ChatRoom(chatroomId: 1,
                 chatroomImage: "Sanlio",
                 chatroomName: "영등포캠퍼스 멘토진방",
                 chatList: [
                    Chat(user: hue,
                         date: "2025-07-12 21:30",
                         message: "열심히 일 하시고 계시는거죠?",
                         bubbleType: nil),
                    Chat(user: bran,
                         date: "2025-07-12 22:32",
                         message: "3층 가고싶어요...",
                         bubbleType: nil),
                    Chat(user: finn,
                         date: "2025-07-12 22:38",
                         message: "화이팅!!",
                         bubbleType: nil),
                    Chat(user: jack,
                         date: "2025-07-12 22:38",
                         message: "으앙",
                         bubbleType: nil),
                    Chat(user: den,
                         date: "2025-07-12 23:42",
                         message: "열심히 하고 있습니다!!",
                         bubbleType: nil),
                 ]
                ),
        ChatRoom(chatroomId: 2,
                 chatroomImage: "Hue",
                 chatroomName: "Hue님 방",
                 chatList: [
                    Chat(user: hue,
                         date: "2025-07-11 15:30",
                         message: "열심히 공부하고 계시는거죠?",
                         bubbleType: nil),
                    Chat(user: me,
                         date: "2025-07-11 15:48",
                         message: "열심히는 하고있어요...",
                         bubbleType: nil),
                    Chat(user: me,
                         date: "2025-07-11 15:49",
                         message: "ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ....",
                         bubbleType: nil),
                    Chat(user: hue,
                         date: "2025-07-12 21:30",
                         message: "오...그러면... 내일 깃허브랑 블로그 전체 검사 진행 진행하도록 하겠습니다...",
                         bubbleType: nil),
                    Chat(user: hue,
                         date: "2025-07-12 21:31",
                         message: "화이팅 ^^",
                         bubbleType: nil),
                 ]),
        ChatRoom(chatroomId: 3,
                 chatroomImage: "Jack",
                 chatroomName: "참새는 짹짹",
                 chatList: [
                    Chat(user: jack,
                         date: "2025-07-11 11:20",
                         message: "김새싹님~ 오늘 깃허브를 보니 커밋을 안해주셨더라구요~~~\n깃허브 푸쉬 부탁드릴게요~~~\n설마 과제를 안하신건 아니시겠죠~~?!",
                         bubbleType: nil),
                    Chat(user: me,
                         date: "2025-07-11 11:23",
                         message: "제.. 제가 푸쉬를 안했군요... 얼른 푸쉬하도록 하겠습니다...",
                         bubbleType: nil),
                    Chat(user: jack,
                         date: "2025-07-11 13:29",
                         message: "김새싹님~ 아직도 푸쉬가 안되어있네요 ^_^ 수업 끝나고 면담 진행하도록 할게요~~ 끝나고 남아주세요~",
                         bubbleType: nil),
                    Chat(user: me,
                         date: "2025-07-11 13:31",
                         message: "넵..",
                         bubbleType: nil),
                    Chat(user: jack,
                         date: "2025-07-11 14:42",
                         message: "면담 때 매일 10시까지 남아있겠다는 말 잘 지키시는지 확인할게요~~/n아 매일은 오늘도 포함인거 아시죠?!",
                         bubbleType: nil),
                    Chat(user: me,
                         date: "2025-07-11 14:50",
                         message: "네....",
                         bubbleType: nil),
                    Chat(user: jack,
                         date: "2025-07-12 20:30",
                         message: "벌써 퇴근하세여?ㅎㅎㅎㅎㅎ",
                         bubbleType: nil),
                 ]),
        ChatRoom(chatroomId: 4,
                 chatroomImage: "Finn",
                 chatroomName: "Finn님 방",
                 chatList: [
                    Chat(user: finn,
                         date: "2025-07-13 09:00",
                         message: "새싹님! 오늘 새로운 프로젝트 시작이에요~",
                         bubbleType: nil),
                    Chat(user: me,
                         date: "2025-07-13 09:15",
                         message: "새 프로젝트라니! 어떤 건가요?",
                         bubbleType: nil),
                    Chat(user: finn,
                         date: "2025-07-13 09:16",
                         message: "날씨 앱을 만들어보는 거예요! API 연동도 배워볼 꼬에요",
                         bubbleType: nil),
                    Chat(user: me,
                         date: "2025-07-13 09:18",
                         message: "오오 재밌을 것 같아요! 네트워크 통신은 아직 익숙하지 않지만 열심히 해볼게요",
                         bubbleType: nil),
                    Chat(user: finn,
                         date: "2025-07-13 09:20",
                         message: "괜찮아요~ 천천히 배워나가면 돼요~ 다할 수 있쥬~",
                         bubbleType: nil),
                    Chat(user: me,
                         date: "2025-07-13 10:30",
                         message: "Finn님 덕분에 개발이 재밌어지고 있어요 ㅎㅎㅎㅎㅎ",
                         bubbleType: nil),
                    Chat(user: finn,
                         date: "2025-07-13 10:32",
                         message: "으쌰으쌰 💪",
                         bubbleType: nil),
                 ]
                ),
        ChatRoom(chatroomId: 5,
                 chatroomImage: "Bran",
                 chatroomName: "브랜브랜브랜님방",
                 chatList: [
                    Chat(user: bran,
                         date: "2025-07-11 21:10",
                         message: "저번 과제 잘 봤습니다!!\n저번 과제에서 이러쿵 저러쿵 부분을 개선해볼 수 있을 것 같은데,\n그 부분까지 개선하셔서 다시 푸쉬해주실 수 있으시겠죠?\n설마 못한다고는 하지 않으시겠죠?",
                         bubbleType: nil),
                    Chat(user: me,
                         date: "2025-07-12 11:12",
                         message: "브랜님! 다름 아니라 제가 어제 저녁에 쪼오오오끔 피곤해서 자느라 다 못했습니다...!",
                         bubbleType: nil),
                    Chat(user: bran,
                         date: "2025-07-12 11:30",
                         message: "보고체계 진행하도록 하겠습니다. 수고하세요.",
                         bubbleType: nil),
                    Chat(user: me,
                         date: "2025-07-12 11:31",
                         message: "한번만 봐주세요.. 다음부터는 다 제출할게요 ㅠㅠㅠ",
                         bubbleType: nil),
                    Chat(user: bran,
                         date: "2025-07-12 11:32",
                         message: "안됩니다.",
                         bubbleType: nil),
                    Chat(user: me,
                         date: "2025-07-12 16:30",
                         message: "예외처리로 한번만 봐주시면 안되나요...?",
                         bubbleType: nil),
                    Chat(user: bran,
                         date: "2025-07-12 19:30",
                         message: "개발자는 예외처리를 싫어합니다.",
                         bubbleType: nil),
                 ]),
        ChatRoom(chatroomId: 6,
                 chatroomImage: "Den",
                 chatroomName: "Den님 방",
                 chatList: [
                    Chat(user: den,
                         date: "2025-07-12 10:30",
                         message: "김새싹님 잔디가 숭숭 빠지셔서 황무지 되시겠어요~ 푸쉬 기다리고 있을게요~",
                         bubbleType: nil),
                    Chat(user: den,
                         date: "2025-07-12 10:31",
                         message: "잔디가 목마르다고 물 달라고 하네요~~",
                         bubbleType: nil),
                    Chat(user: den,
                         date: "2025-07-12 10:31",
                         message: "물물",
                         bubbleType: nil),
                    Chat(user: den,
                         date: "2025-07-12 10:31",
                         message: "물물물",
                         bubbleType: nil),
                    Chat(user: den,
                         date: "2025-07-12 10:31",
                         message: "물물물물",
                         bubbleType: nil),
                    Chat(user: den,
                         date: "2025-07-12 11:31",
                         message: "어디가셨어요~~",
                         bubbleType: nil),
                    Chat(user: den,
                         date: "2025-07-12 15:32",
                         message: "차단한 건 아니시죠, 김새싹님?",
                         bubbleType: nil),
                    Chat(user: den,
                         date: "2025-07-12 16:10",
                         message: "오늘 주말이에요... 살려주세요..",
                         bubbleType: nil),
                    Chat(user: den,
                         date: "2025-07-12 16:30",
                         message: "잔디는 생물이라 매일 물줘야 살아요.",
                         bubbleType: nil),
                    Chat(user: den,
                         date: "2025-07-12 16:32",
                         message: "푸시\n푸시\n커밋\n커밋\n으하하하\n푸시푸시",
                         bubbleType: nil),
                    Chat(user: me,
                         date: "2025-07-12 19:10",
                         message: "오늘 주말이에요... 살려주세요 덴님... 주말이 평일보다 힘듭니다",
                         bubbleType: nil),
                    Chat(user: den,
                         date: "2025-07-12 19:13",
                         message: "저도 주말인데 김새싹님 깃허브 보고 있잖아요...?",
                         bubbleType: nil),
                    Chat(user: me,
                         date: "2025-07-12 19:14",
                         message: "...",
                         bubbleType: nil),
                 ]),
        ChatRoom(chatroomId: 7,
                 chatroomImage: "Other",
                 chatroomName: "Other Friend님 방",
                 chatList: [
                    Chat(user: me,
                         date: "2025-07-12 10:30",
                         message: "아 오늘 주말인데도 개발하고있어 ㅠㅠㅠㅠ 너는 이번 주말 과제 어때?? 괜찮아?",
                         bubbleType: nil),
                    Chat(user: other_friend,
                         date: "2025-07-12 10:33",
                         message: "난 이미 어제 밤에 제출하고 미션하고있는데? 아직도 구현못했어?",
                         bubbleType: nil),
                    Chat(user: me,
                         date: "2025-07-12 11:08",
                         message: "어? 어... 어제 다했구나...? 빠르네...!",
                         bubbleType: nil),
                    Chat(user: me,
                         date: "2025-07-12 12:52",
                         message: "채팅방 구현 어렵다 ㅠㅠㅠ 오토레이아웃 왜이렇게어렵지 ㅠㅠㅠ",
                         bubbleType: nil),
                    Chat(user: other_friend,
                         date: "2025-07-12 13:45",
                         message: "내일 모닝콜 해주실분~~",
                         bubbleType: nil),
                 ]
                ),
        ChatRoom(chatroomId: 8,
                 chatroomImage: "Simsim",
                 chatroomName: "심심이님 방",
                 chatList: [
                    Chat(user: me,
                         date: "2025-07-11 09:30",
                         message: "심심아 나 주말에도 개발해...",
                         bubbleType: nil),
                    Chat(user: simsim,
                         date: "2025-07-11 09:31",
                         message: "아닛 주말에 과제라닛",
                         bubbleType: nil),
                    Chat(user: me,
                         date: "2025-07-11 09:32",
                         message: "ㅠㅠㅠ 주말에 개발하는 날 공감해주는게 너밖에 없어",
                         bubbleType: nil),
                    Chat(user: simsim,
                         date: "2025-07-11 09:33",
                         message: "아닛 주말에 과제라닛",
                         bubbleType: nil),
                    Chat(user: me,
                         date: "2025-07-11 09:34",
                         message: "...? 심심아...?",
                         bubbleType: nil),
                    Chat(user: simsim,
                         date: "2025-07-11 09:35",
                         message: "아닛 주말에 과제라닛",
                         bubbleType: nil),
                    Chat(user: me,
                         date: "2025-07-11 09:36",
                         message: "...",
                         bubbleType: nil),
                    Chat(user: simsim,
                         date: "2025-07-11 09:37",
                         message: "아닛 주말에 과제라닛",
                         bubbleType: nil),
                 ]
                )
    ]
    
    static func sortLatestTalkList() {
        ChatList.list.sort{$0.chatList.last?.date ?? "" > $1.chatList.last?.date ?? ""}
    }
}
