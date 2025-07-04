//
//  BMIViewController.swift
//  SeSAC7Week1Remind
//
//  Created by 정성희 on 7/4/25.
//

import UIKit

class BMIViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    

    func setUI() {
        titleLabel.text = "test"
    }

}
