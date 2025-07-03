//
//  ViewController.swift
//  SearchNewWord
//
//  Created by 정성희 on 7/3/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var meanLabel: UILabel!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var recommendButton: [UIButton]!
    
    var newWordList = ["꾸안꾸" : "꾸민듯 안 꾸민듯",
                       "스불재" : "스스로 불러온 재앙의 줄임말",
                       "갓생" : "갓(God) + 인생 = 성실하고 생산적으로 사는 삶.",
                       "손민수" : "누군가를 따라 할 때 사용.",
                       "억까" : "억지로 까기의 줄임말",
                       "jmt" : "매우 맛있다 라는 의미로 사용됨.",
                       "ttm" : "Too Tired to Move의 줄임말."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFieldUI()
        setLabelUI()
        setSearchButtonUI()
        setRecommendButtonUI()
    }
    
    // MARK: - LOGIC
    
    // 신조어 검색 후 값이 존재하면 화면에 보여주는 함수
    // 입력한 신조어를 소문자로 변경 후 검색하게 함
    func searchNewWord() {
        var flag = false
        guard let text = searchTextField.text?.lowercased() else { return }
        
        for (key, value) in newWordList {
            if key == text { // 알맞은 단어를 찾음
                meanLabel.text = value
                flag = true
                break
            }
        }
        
        if flag == false {
            meanLabel.text = "검색결과가 없습니다"
        }
    }
    
    // MARK: - IBAction Button
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        searchNewWord()
        view.endEditing(true)
    }

    @IBAction func searchTextFieldResultTapped(_ sender: UITextField) {
        searchNewWord()
    }
    
    @IBAction func recommendButtonTapped(_ sender: UIButton) {
        searchTextField.text = sender.currentTitle
        searchNewWord()
    }

    @IBAction func keyboardDismiss(_ sender: Any) {
        view.endEditing(true)
    }
    
    // MARK: - UI Setting
    func setTextFieldUI() {
        searchTextField.attributedPlaceholder = NSAttributedString(string: "신조어를 검색해보세요", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        searchTextField.backgroundColor = .white
        searchTextField.font = .systemFont(ofSize: 14)
        searchTextField.textColor = .black
        searchTextField.borderStyle = .line
        
        // 입력하는 부분 왼쪽에 간격 추가
        searchTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 0.0))
        searchTextField.leftViewMode = .always
    }
    
    func setLabelUI() {
        meanLabel.text = "여기서 신조어에 대한 뜻을 알려드릴게요"
        meanLabel.font = .systemFont(ofSize: 17)
        meanLabel.textColor = .black
        meanLabel.textAlignment = .center
    }
    
    func setSearchButtonUI() {
        searchButton.backgroundColor = .black
        searchButton.tintColor = .white
    }
    
    func setRecommendButtonUI() {
        var count = 0
        for key in newWordList{
            recommendButton[count].setTitle(key.0, for: .normal)
            recommendButton[count].setTitleColor(.black, for: .normal)
            recommendButton[count].backgroundColor = .white
            recommendButton[count].titleLabel?.font = UIFont.systemFont(ofSize: 14)
            recommendButton[count].layer.borderColor = UIColor.black.cgColor
            recommendButton[count].layer.borderWidth = 1
            recommendButton[count].layer.cornerRadius = 7
            recommendButton[count].clipsToBounds = true
            recommendButton[count].sizeToFit()
            count += 1
        }
    }
}
