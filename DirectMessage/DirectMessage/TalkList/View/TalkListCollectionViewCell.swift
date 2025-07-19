//
//  TalkListCollectionViewCell.swift
//  DirectMessage
//
//  Created by 정성희 on 7/19/25.
//

import UIKit

class TalkListCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TalkListCollectionViewCell"
    
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var lastChatLabel: UILabel!
    @IBOutlet var lastChatDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI() {
        nameLabel.font = .systemFont(ofSize: 15)
        nameLabel.textColor = .black
        nameLabel.textAlignment = .left
        
        lastChatLabel.font = .systemFont(ofSize: 13)
        lastChatLabel.textColor = .lightGray
        lastChatLabel.textAlignment = .left
        
        lastChatDateLabel.font = .systemFont(ofSize: 11)
        lastChatDateLabel.textColor = .lightGray
        lastChatDateLabel.textAlignment = .right
    }
    
    func configureData(_ row: ChatRoom) {
        profileImage.image = UIImage(named: row.chatroomImage)
        nameLabel.text = row.chatroomName
        lastChatLabel.text = row.getLastChatText
        lastChatDateLabel.text = row.getLastChatDate
    }
}
