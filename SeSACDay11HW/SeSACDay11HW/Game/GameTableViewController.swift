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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.isEditable = false
    }
    
    @IBAction func textFieldTapEnter(_ sender: UITextField) {
        getGameStringValue()
    }
    
    func getGameStringValue() {
        var result = ""
        
        guard let text = textField.text else { return }
        
        guard text != "" else {
            textView.text = "숫자를 입력해주세요!"
            return
        }
        
        guard Int(text) != nil else {
            textView.text = "문자가 아닌 숫자만 입력해주세요!"
            return
        }
        
        for i in 1...Int(text)! {
            result += "\(getHardResult(text: String(i))), "
        }
        
        result.popLast()!
        result.popLast()!
        
        textView.text = result
    }
    
    func getSimpleResult(text: String) -> String {
        for char in text {
            if char == "3" || char == "6" || char == "9" { return "👏" }
        }
        
        return text
    }
    
    func getHardResult(text: String) -> String {
        var result = ""
        
        for char in text {
            if char == "3" || char == "6" || char == "9" { result += "👏" }
            else { result += String(char) }
        }
        
        return result
    }
}
