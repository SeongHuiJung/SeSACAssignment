//
//  NaverPayViewController.swift
//  SeSAC7Week1Remind
//
//  Created by 정성희 on 7/6/25.
//

import UIKit

class NaverPayViewController: UIViewController {

    @IBOutlet var payTypeButton: [UIButton]!
    @IBOutlet var popView: UIView!
    @IBOutlet var confirmButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAllButtonUI()
        setPopView()
    }
    
    func setPopView() {
        popView.layer.cornerRadius = 15
        popView.clipsToBounds = true
    }
    
    func setAllButtonUI() {
        setPayTypeButtonUI(button: payTypeButton[0])
        setPayTypeButtonUI(button: payTypeButton[2])
        
        payTypeButton[1].backgroundColor = .lightGray
        payTypeButton[1].setTitleColor(.white, for: .normal)
        payTypeButton[1].layer.cornerRadius = 15
        payTypeButton[1].clipsToBounds = true
        
        confirmButton.layer.cornerRadius = 15
        confirmButton.clipsToBounds = true
    }
    
    func setPayTypeButtonUI(button: UIButton) {
        button.backgroundColor = .black
        button.setTitleColor(.darkGray, for: .normal)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
    }
}
