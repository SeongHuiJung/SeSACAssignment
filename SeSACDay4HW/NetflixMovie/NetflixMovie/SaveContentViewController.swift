//
//  SaveContentViewController.swift
//  NetflixMovie
//
//  Created by 정성희 on 7/2/25.
//

import UIKit

class SaveContentViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var subLabel1: UILabel!
    @IBOutlet var subLabel2: UILabel!
    @IBOutlet var seriesImage: UIImageView!
    
    @IBOutlet var settingButton: UIButton!
    @IBOutlet var arroundButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLabelUI()
        setImageUI()
        setAllButtonUI()
    }
    
    func setLabelUI() {
        titleLabel.text = "저장한 콘텐츠 목록"
        titleLabel.font = .systemFont(ofSize: 20,weight: .bold)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        
        mainLabel.text = "'나만의 자동 저장' 기능"
        mainLabel.font = .systemFont(ofSize: 20, weight: .bold)
        mainLabel.textColor = .white
        mainLabel.textAlignment = .center
        
        subLabel1.text = "취향에 맞는 영화와 시리즈를 자동으로 저장해 드립니다."
        subLabel1.font = .systemFont(ofSize: 13)
        subLabel1.textColor = .lightGray
        subLabel1.textAlignment = .center
        
        subLabel2.text = "디바이스에서 언제나 시청할 콘텐츠가 준비되니 지루할 틈이 없어요."
        subLabel2.font = .systemFont(ofSize: 13)
        subLabel2.textColor = .lightGray
        subLabel2.textAlignment = .center
    }
    func setImageUI() {
        seriesImage.image = UIImage(named: "dummy")
    }
    
    func setAllButtonUI() {
        setButtonUI(button: settingButton, text: "설정하기", textColor: .white, backgroundColor: .systemBlue)
        setButtonUI(button: arroundButton, text: "저장 가능한 콘텐츠 살펴보기", textColor: .black, backgroundColor: .white)
    }
    
    func setButtonUI(button: UIButton, text: String, textColor: UIColor, backgroundColor: UIColor) {
        button.setTitle(text, for: .normal)
        button.setTitleColor(textColor, for: .normal)
        button.backgroundColor = backgroundColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
    }
}
