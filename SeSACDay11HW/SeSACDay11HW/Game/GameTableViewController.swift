//
//  GameTableViewController.swift
//  SeSACDay11HW
//
//  Created by 정성희 on 7/12/25.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    @IBOutlet var textView: UITextView!
    @IBOutlet var clapCountLabel: UILabel!
    var clapCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.isEditable = false
        setLabelUI()
    }
    
    @IBAction func textFieldTapEnter(_ sender: UITextField) {
        clapCount = 0
        getGameStringValue()
        clapCountLabel.text = "숫자 \(textField.text!)까지 총 박수는 \(String(clapCount))번 입니다."
    }
    
    func getGameStringValue() {
        var result = ""
        
        guard let text = textField.text else { return }
        
        guard text != "" else {
            textView.text = "숫자를 입력해주세요!"
            return
        }
        
        guard let text = Int(text) else {
            textView.text = "문자가 아닌 숫자만 입력해주세요!"
            return
        }
        
        guard text >= 1 else {
            textView.text = "1 이상 입력해주세요!"
            return
        }
        
        guard text <= 1000 else {
            textView.text = "1000 이하로 입력해주세요!"
            return
        }
        
        for i in 1...text {
            let value = getHardResult(text: String(i))
            let text = value.0
            let clapCount = value.1
            
            self.clapCount += clapCount
            result += "\(text), "
        }
        
        result.popLast()!
        result.popLast()!
        
        textView.text = result
    }
    
    func getSimpleResult(text: String) -> (String, Int) {
        var result = text
        var clapCount = 0
        
        for char in text {
            if char == "3" || char == "6" || char == "9" {
                result = "👏"
                clapCount += 1
                break
            }
        }
        
        return (result, clapCount)
    }
    
    func getHardResult(text: String) -> (String, Int) {
        var result = ""
        var clapCount = 0
        
        for char in text {
            if char == "3" || char == "6" || char == "9" {
                result += "👏"
                clapCount += 1
            }
            else { result += String(char) }
        }
        
        return (result, clapCount)
    }
    
    func setLabelUI() {
        clapCountLabel.font = .systemFont(ofSize: 30, weight: .bold)
        clapCountLabel.textColor = UIColor.black
        clapCountLabel.textAlignment = .center
        clapCountLabel.numberOfLines = 0
    }
}
