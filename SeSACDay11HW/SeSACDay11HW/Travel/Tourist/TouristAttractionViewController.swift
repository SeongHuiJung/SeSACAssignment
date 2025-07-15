//
//  TouristAttractionViewController.swift
//  SeSACDay11HW
//
//  Created by 정성희 on 7/15/25.
//

import UIKit

class TouristAttractionViewController: UIViewController {

    @IBOutlet var anotherTouristShowButton: UIButton!
    static let identifier = "TouristAttractionViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationUI()
        setButtonUI(anotherTouristShowButton, text: "다른 관광지 보러 가기")
    }
}

// Action
extension TouristAttractionViewController {
    @IBAction func anotherTouristShowButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

// Navigation
extension TouristAttractionViewController {
    func setNavigationUI() {
        navigationItem.title = "관광지 화면"
    }
}
