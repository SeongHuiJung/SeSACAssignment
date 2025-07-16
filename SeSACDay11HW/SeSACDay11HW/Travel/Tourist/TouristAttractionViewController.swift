//
//  TouristAttractionViewController.swift
//  SeSACDay11HW
//
//  Created by 정성희 on 7/15/25.
//

import UIKit

class TouristAttractionViewController: UIViewController {

    @IBOutlet var travelImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    static let identifier = "TouristAttractionViewController"
    
    @IBOutlet var anotherTouristShowButton: UIButton!
    
    var tourData: Travel = Travel(title: "", description: nil, travel_image: nil, grade: nil, save: nil, like: nil, ad: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setNavigationUI()
        setButtonUI(anotherTouristShowButton, text: "다른 관광지 보러 가기")
    }
}

// MARK: - Action
extension TouristAttractionViewController {
    @IBAction func anotherTouristShowButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Navigation
extension TouristAttractionViewController {
    func setNavigationUI() {
        navigationItem.title = "관광지 화면"
    }
}

// MARK: - UI
extension TouristAttractionViewController {
    func setUI() {
        titleLabel.text = tourData.title
        descriptionLabel.text = tourData.description
        travelImage.setDownSamplingImage(url: tourData.travel_image)
    }
}
