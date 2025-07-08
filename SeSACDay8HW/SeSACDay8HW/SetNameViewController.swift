//
//  SetNameViewController.swift
//  SeSACDay8HW
//
//  Created by 정성희 on 7/8/25.
//

import UIKit

class SetNameViewController: UIViewController {

    @IBOutlet var tabNavigationBar: UINavigationItem!
    @IBOutlet var textField: UITextField!
    @IBOutlet var textCountLabel: UILabel!
    @IBOutlet var hintLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setTextField()
        

    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let text = textField.text else { return }
        
        if 2 <= text.count && text.count <= 6 {
            UserDefaults.standard.set(text, forKey: "userName")
            navigationController?.popViewController(animated: true)
            tabNavigationBar.title = text + "님 이름 정하기"
        }
    }
    @IBAction func textField(_ sender: UITextField) {
        guard let text = textField.text else { return }

        textCountLabel.text = String(text.count)
        
        if text.count < 2 || text.count > 6 {
            hintLabel.text = "글자는 2글자 이상 6글자 이하이어야해요"
        }
        else { hintLabel.text = "" }
    }
    
    @IBAction func nameTextFieldKeyboardDown(_ sender: UITextField) {}
    
    func setUI() {
        tabNavigationBar.title = (UserDefaults.standard.string(forKey: "userName") ?? "대장") + "님 이름 정하기"
        
        hintLabel.text = ""
        hintLabel.font = .systemFont(ofSize: 14)
        hintLabel.textColor = .red
        hintLabel.textAlignment = .left
        
        view.backgroundColor = .second
        
        tabNavigationBar.rightBarButtonItem?.tintColor = .primary
        tabNavigationBar.titleView?.tintColor = .primary
    }
    
    func setTextField() {
        textField.attributedPlaceholder = NSAttributedString(string: "이름을 적어주세요!", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        textField.backgroundColor = .second
        textField.font = .systemFont(ofSize: 15)
        textField.textColor = .primary

        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.primary.cgColor
        
        // 입력하는 부분 왼쪽에 간격 추가
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 0.0))
        textField.leftViewMode = .always
    }
}
