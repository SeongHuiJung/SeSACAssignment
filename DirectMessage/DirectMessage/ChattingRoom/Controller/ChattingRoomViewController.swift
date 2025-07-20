//
//  ChattingRoomViewController.swift
//  DirectMessage
//
//  Created by 정성희 on 7/19/25.
//

import UIKit

class ChattingRoomViewController: UIViewController {

    static let identifier = "ChattingRoomViewController"
    
    @IBOutlet var textView: UITextView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var sendChatButton: UIButton!
    
    var chatData = ChatRoom(chatroomId: 0, chatroomImage: "", chatroomName: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

// MARK: - Action
extension ChattingRoomViewController {
    @IBAction private func sendChatButtonTapped(_ sender: UIButton) {
        guard let text = textView.text else { return }
        guard !text.isEmpty else { return }
        guard !isOnlyWhiteSpace(text: text) else { return }
        
        let chatRoomId = chatData.chatroomId
        
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString = format.string(from: Date())
        
        let newChat = Chat(user: User(name: "김새싹", image: "Me"), date: dateString, message: text)
        
        ChatList.list[chatRoomId - 1].chatList.append(newChat)
        
        fetchData(chatRoomId: chatRoomId)
        showLastChat()
        textView.text = ""
        resetTextViewSize()
    }
}

// MARK: - Logic
extension ChattingRoomViewController {
    private func showLastChat() {
        let lastIndex = IndexPath(row: chatData.chatList.count - 1, section: 0)
        tableView.scrollToRow(at: lastIndex, at: .bottom, animated: false)
    }
    
    private func fetchData(chatRoomId: Int) {
        chatData = ChatList.list[chatRoomId - 1]
        tableView.reloadData()
    }
    
    private func resetTextViewSize() {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
    
    private func isOnlyWhiteSpace(text: String) -> Bool {
        for char in text {
            if char != "\n" && char != " " {
                return false
            }
        }
        return true
    }
}

// MARK: - TextView Delegate
extension ChattingRoomViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard let lineHeight = textView.font?.lineHeight else { return }
        
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)

        textView.constraints.forEach { (constraint) in
            if estimatedSize.height <= 16.6 + lineHeight * 3 {
                if constraint.firstAttribute == .height {
                    constraint.constant = estimatedSize.height
                }
            }
        }
    }
}

// MARK: - TableView Delegate
extension ChattingRoomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chatData.chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if chatData.chatList[indexPath.row].user.name == "김새싹" {
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatBubbleUserTableViewCell.identifier, for: indexPath) as! ChatBubbleUserTableViewCell
            
            cell.configure(item: chatData.chatList[indexPath.row])
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatBubbleOtherUserTableViewCell.identifier, for: indexPath) as! ChatBubbleOtherUserTableViewCell
            
            cell.configure(item: chatData.chatList[indexPath.row])

            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - UI & Standard Setting
extension ChattingRoomViewController {
    private func configure() {
        setNib(identifier: ChatBubbleOtherUserTableViewCell.identifier, object: tableView)
        setNib(identifier: ChatBubbleUserTableViewCell.identifier, object: tableView)
        
        setDelegate()
        
        tableView.separatorStyle = .none
        setNavigation()
        setButton()
        setTextView()
        
        showLastChat()
    }
    
    private func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
        textView.delegate = self
    }
    
    private func setNavigation() {
        navigationItem.title = chatData.chatroomName
    }
    
    private func setButton() {
        sendChatButton.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        sendChatButton.tintColor = .gray
    }
    
    private func setTextView() {
        textView.backgroundColor = .systemGray6
        textView.layer.cornerRadius = 15
        textView.clipsToBounds = true
        textView.textContainer.lineFragmentPadding = 15

        resetTextViewSize()
    }
}

