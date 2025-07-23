//
//  ChatBubbleOtherUserSequenceFirstTableViewCell.swift
//  DirectMessage
//
//  Created by 정성희 on 7/23/25.
//

import UIKit

class ChatBubbleOtherUserSequenceFirstTableViewCell: UITableViewCell {

    static let identifier = "ChatBubbleOtherUserSequenceFirstTableViewCell"
    
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var bubbleView: UIView!
    @IBOutlet var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
}

extension ChatBubbleOtherUserSequenceFirstTableViewCell: CellViewProtocol {
    func configure() {
        nameLabel.font = .systemFont(ofSize: 12)
        nameLabel.textColor = .black
        nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 0
        
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
        profileImage.image = UIImage(named: item.user.image)
        nameLabel.text = item.user.name
        contentLabel.text = item.message
    }
}

