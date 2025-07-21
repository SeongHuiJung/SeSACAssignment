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
    
    var sectionData: [[Chat]] = []
    var dateDivisionLineSet: Set<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 실행 시점 옮겨주기
        // 더 나중에 실행하도록 함
        DispatchQueue.main.async { [weak self] in
            self?.showLastChat()
        }
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
        addNewChatSectionData(newChat: newChat)
        
        fetchData(chatRoomId: chatRoomId)
        showLastChat()
        textView.text = ""
        resetTextViewSize()
    }
}

// MARK: - Logic
extension ChattingRoomViewController {
    private func showLastChat() {
        let lastIndex = IndexPath(row: sectionData[sectionData.count - 1].count - 1, section: sectionData.count - 1)
        tableView.scrollToRow(at: lastIndex, at: .middle, animated: false)
    }
    
    private func fetchData(chatRoomId: Int) {
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
    
    private func divisionSectionData() {
        for chat in chatData.chatList {
            guard let dateString = chat.getDateDivisionFormattedString else { return }
            addChatDataToSectionData(dateString: dateString, chat: chat)
        }
    }
    
    private func addNewChatSectionData(newChat: Chat) {
        guard let dateString = newChat.getDateDivisionFormattedString else { return }
        addChatDataToSectionData(dateString: dateString, chat: newChat)
    }
    
    private func addChatDataToSectionData(dateString: String, chat: Chat) {
        // 이미 동일한 날짜 데이터가 있는 경우
        if dateDivisionLineSet.contains(dateString) {
            sectionData[sectionData.count - 1].append(chat)
        }
        
        // 새로운 날짜 데이터 추가
        else {
            dateDivisionLineSet.insert(dateString)
            sectionData.append([Chat(user: User(name: "", image: ""), date: "", message: ""),chat])
        }
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sectionData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // cell 타입별로 분류하기
        // switch 사용
        // 실제 서비스라고 생각하고 "김새싹" 처리해줄것
        if indexPath.row == 0 {
            let dateString = sectionData[indexPath.section][indexPath.row + 1].getDateDivisionFormattedString ?? ""
            let cell = tableView.dequeueReusableCell(withIdentifier: DateLineTableViewCell.identifier, for: indexPath) as! DateLineTableViewCell
            
            cell.configureData(text: dateString)
            
            return cell
        }
        else {
            if sectionData[indexPath.section][indexPath.row].user.name == "김새싹" {
                let cell = tableView.dequeueReusableCell(withIdentifier: ChatBubbleUserTableViewCell.identifier, for: indexPath) as! ChatBubbleUserTableViewCell
                
                cell.configure(item: sectionData[indexPath.section][indexPath.row])
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: ChatBubbleOtherUserTableViewCell.identifier, for: indexPath) as! ChatBubbleOtherUserTableViewCell
                
                cell.configure(item: sectionData[indexPath.section][indexPath.row])

                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - UI & Standard Setting
extension ChattingRoomViewController {
    private func configure() {
        divisionSectionData()

        setNib(identifier: ChatBubbleOtherUserTableViewCell.identifier, object: tableView)
        setNib(identifier: ChatBubbleUserTableViewCell.identifier, object: tableView)
        setNib(identifier: DateLineTableViewCell.identifier, object: tableView)
        
        setDelegate()
        
        tableView.separatorStyle = .none
        setNavigation()
        setButton()
        setTextView()
        
        
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

