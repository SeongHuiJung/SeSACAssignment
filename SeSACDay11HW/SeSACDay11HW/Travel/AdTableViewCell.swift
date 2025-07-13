//
//  AdTableViewCell.swift
//  SeSACDay11HW
//
//  Created by 정성희 on 7/13/25.
//

import UIKit

class AdTableViewCell: UITableViewCell {

    @IBOutlet var advertisementLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setLabelUI()
    }
    
    func setLabelUI() {
        advertisementLabel.numberOfLines = 0
        advertisementLabel.font = .systemFont(ofSize: 14, weight: .bold)
        advertisementLabel.textColor = .black
        advertisementLabel.textAlignment = .center
    }
}
