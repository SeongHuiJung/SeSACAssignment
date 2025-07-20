//
//  ChatBubbleOtherUserTableViewCell.swift
//  DirectMessage
//
//  Created by 정성희 on 7/19/25.
//

import UIKit

class ChatBubbleOtherUserTableViewCell: UITableViewCell {

    static let identifier = "ChatBubbleOtherUserTableViewCell"
    
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var bubbleView: UIView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    private func configureUI() {
        nameLabel.font = .systemFont(ofSize: 12)
        nameLabel.textColor = .black
        nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 0
        
        contentLabel.font = .systemFont(ofSize: 13)
        contentLabel.textColor = .black
        contentLabel.textAlignment = .left
        contentLabel.numberOfLines = 0
        
        timeLabel.font = .systemFont(ofSize: 11)
        timeLabel.textColor = .black
        timeLabel.textAlignment = .left
        
        bubbleView.layer.borderColor = UIColor.lightGray.cgColor
        bubbleView.layer.borderWidth = 1
        bubbleView.layer.cornerRadius = 10
        
        self.selectionStyle = .none
    }
    
    func configure(item: Chat) {
        profileImage.image = UIImage(named: item.user.image)
        nameLabel.text = item.user.name
        timeLabel.text = item.getFormattedDateString
        contentLabel.text = item.message
    }
}
