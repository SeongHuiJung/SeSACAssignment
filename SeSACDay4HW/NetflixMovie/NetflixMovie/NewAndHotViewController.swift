//
//  NewAndHotViewController.swift
//  NetflixMovie
//
//  Created by 정성희 on 7/2/25.
//

import UIKit

class NewAndHotViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var radioButton: [UIButton]!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var subLabel: UILabel!
    
    let mainTextList = ["이런, 찾으시는 작품이 없습니다.", "모두의 인기 콘텐츠를 즐겨보세요.", "TOP 10 시리즈를 공개합니다!"]
    
    var selectedButtonIndex: Int = 0 {
        didSet {
            switch selectedButtonIndex {
            case 0:
                changeButtonColorToTrue(button: radioButton[0])
                changeButtonColorToFalse(button: radioButton[1])
                changeButtonColorToFalse(button: radioButton[2])
                mainLabel.text = mainTextList[0]
            case 1:
                changeButtonColorToTrue(button: radioButton[1])
                changeButtonColorToFalse(button: radioButton[0])
                changeButtonColorToFalse(button: radioButton[2])
                mainLabel.text = mainTextList[1]
            case 2:
                changeButtonColorToTrue(button: radioButton[2])
                changeButtonColorToFalse(button: radioButton[0])
                changeButtonColorToFalse(button: radioButton[1])
                mainLabel.text = mainTextList[2]
            default:
                changeButtonColorToTrue(button: radioButton[0])
                changeButtonColorToFalse(button: radioButton[1])
                changeButtonColorToFalse(button: radioButton[2])
                mainLabel.text = mainTextList[0]
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAllRadioButtonUI()
        setTitleLabelUI()
        setMainAndSubLabelUI()
        setRadioButtonTag()
        setSearchTextFieldUI()
        
        selectedButtonIndex = 0
    }
    
    // MARK: - Action
    @IBAction func radioButtonTapped(_ sender: UIButton) {
        print(sender.tag)
        switch sender.tag {
        case 0: selectedButtonIndex = 0
        case 1: selectedButtonIndex = 1
        case 2: selectedButtonIndex = 2
        default: selectedButtonIndex = 0
        }
    }
    
    @IBAction func textFieldReturnTapped(_ sender: UITextField) {}
    
    // MARK: - LOGIC
    func changeButtonColorToTrue(button: UIButton) {
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
    }
    func changeButtonColorToFalse(button: UIButton) {
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
    }
    
    // MARK: - UI
    func setTitleLabelUI() {
        titleLabel.text = "NEW & HOT 검색"
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.textAlignment = .center
    }
    func setMainAndSubLabelUI() {
        mainLabel.font = .systemFont(ofSize: 20, weight: .bold)
        mainLabel.textColor = .white
        mainLabel.textAlignment = .center
        
        subLabel.text = "다른 영화, 시리즈, 배우, 감독 또는 장르를 검색해 보세요."
        subLabel.font = .systemFont(ofSize: 15)
        subLabel.textColor = .lightGray
        subLabel.textAlignment = .center
    }
    func setSearchTextFieldUI() {
        searchTextField.attributedPlaceholder = NSAttributedString(string: "게임, 시리즈, 영화를 검색하세요...", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        searchTextField.backgroundColor = .darkGray
        searchTextField.font = .systemFont(ofSize: 14)
        searchTextField.textColor = .lightGray
    }
    func setAllRadioButtonUI() {
        let imageList = ["blue", "turquoise", "pink"]
        let textList = ["공개 예정", "모두의 인기 컨텐츠", "TOP 10 시리즈"]
        for i in 0..<radioButton.count {
            setRadioButtonUI(button: radioButton[i], image: imageList[i], text: textList[i])
        }
    }
    func setRadioButtonUI(button: UIButton, image: String, text: String) {
        button.setTitle(text, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setImage(UIImage(named: image), for: .normal)
        button.backgroundColor = .black
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        setButtonCorner(button: button)
    }
    func setButtonCorner(button: UIButton) {
        button.layer.cornerRadius = 18
        button.clipsToBounds = true
    }
    func setRadioButtonTag() {
        for i in 0..<radioButton.count {
            radioButton[i].tag = i
        }
    }
}
