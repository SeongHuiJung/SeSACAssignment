//
//  KaKaoTalkProfileViewController.swift
//  SeSAC7Week1Remind
//
//  Created by 정성희 on 7/6/25.
//

import UIKit

class KaKaoTalkProfileViewController: UIViewController {

    @IBOutlet var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setProfileUI()
    }
    
    func setProfileUI() {
        profileImage.layer.cornerRadius = 30
        profileImage.clipsToBounds = true
    }
}
