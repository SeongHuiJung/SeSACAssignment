//
//  AdTableViewCell.swift
//  SeSACDay11HW
//
//  Created by 정성희 on 7/14/25.
//

import UIKit

class AdTableViewCell: UITableViewCell {

    static let identifier = "AdTableViewCell"
    
    @IBOutlet var advertisementLabel: UILabel!
    
    let adBackgroundColorList: [UIColor] = [.yellow, .systemPink, .systemBlue, .systemMint]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setStandardUI()
        setLabelUI()
    }
    
    func setStandardUI() {
        backgroundColor = adBackgroundColorList.randomElement()
    }
    
    func setLabelUI() {
        advertisementLabel.numberOfLines = 0
        advertisementLabel.font = .systemFont(ofSize: 14, weight: .bold)
        advertisementLabel.textColor = .black
        advertisementLabel.textAlignment = .center
    }
    
    func configureAdCellUI(row: Travel) {
        advertisementLabel.text = row.title
    }
}
