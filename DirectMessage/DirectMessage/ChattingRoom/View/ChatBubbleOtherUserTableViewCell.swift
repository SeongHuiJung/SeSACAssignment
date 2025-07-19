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
        
    }
    
    func configure(item: Chat) {
        profileImage.image = UIImage(named: item.user.image)
        nameLabel.text = item.user.name
        timeLabel.text = item.date
        contentLabel.text = item.message
    }
}
