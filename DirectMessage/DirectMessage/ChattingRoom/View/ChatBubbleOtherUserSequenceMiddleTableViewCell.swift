//
//  ChatBubbleOtherUserSequenceMiddleTableViewCell.swift
//  DirectMessage
//
//  Created by 정성희 on 7/23/25.
//

import UIKit

class ChatBubbleOtherUserSequenceMiddleTableViewCell: UITableViewCell {
    
    static let identifier = "ChatBubbleOtherUserSequenceMiddleTableViewCell"
    
    @IBOutlet var bubbleView: UIView!
    @IBOutlet var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
}

extension ChatBubbleOtherUserSequenceMiddleTableViewCell: CellViewProtocol {
    func configure() {
        contentLabel.font = .systemFont(ofSize: 13)
        contentLabel.textColor = .black
        contentLabel.textAlignment = .left
        contentLabel.numberOfLines = 0

        bubbleView.layer.borderColor = UIColor.lightGray.cgColor
        bubbleView.layer.borderWidth = 1
        bubbleView.layer.cornerRadius = 10
        
        self.selectionStyle = .none
    }
    
    func configureData(item: Chat) {
        contentLabel.text = item.message
    }
}
