//
//  ChattingRoomViewController.swift
//  DirectMessage
//
//  Created by 정성희 on 7/19/25.
//

import UIKit

class ChattingRoomViewController: UIViewController {

    static let identifier = "ChattingRoomViewController"
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var textField: UITextField!
    
    var chatData = ChatRoom(chatroomId: 0, chatroomImage: "", chatroomName: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}


// MARK: Login
extension ChattingRoomViewController {
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
        tableView.separatorStyle = .none
        setDelegate()
        setNavigation()
    }
    
    private func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setNavigation() {
        navigationItem.title = chatData.chatroomName
    }
}
