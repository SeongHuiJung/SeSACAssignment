//
//  ChatBubbleOtherUserSequenceLastTableViewCell.swift
//  DirectMessage
//
//  Created by 정성희 on 7/23/25.
//

import UIKit

class ChatBubbleOtherUserSequenceLastTableViewCell: UITableViewCell {

    static let identifier = "ChatBubbleOtherUserSequenceLastTableViewCell"
    
    @IBOutlet var bubbleView: UIView!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
}


extension ChatBubbleOtherUserSequenceLastTableViewCell: CellViewProtocol {
    func configure() {
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
    
    func configureData(item: Chat) {
        timeLabel.text = item.getFormattedDateString
        contentLabel.text = item.message
    }
}
