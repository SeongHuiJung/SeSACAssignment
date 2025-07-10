//
//  ViewController.swift
//  SeSACDay8HW
//
//  Created by 정성희 on 7/8/25.
//

import UIKit

class TamagochiViewController: UIViewController {
    @IBOutlet var navigationBarTitle: UINavigationItem!
    
    @IBOutlet var damagochiImage: UIImageView!
    @IBOutlet var damagochiNameLabel: UILabel!
    @IBOutlet var damagochiSpeechLabel: UILabel!
    
    @IBOutlet var stateLabel: UILabel!
    
    @IBOutlet var riceTextField: UITextField!
    @IBOutlet var waterBubbleTextField: UITextField!
    
    @IBOutlet var riceButton: UIButton!
    @IBOutlet var waterBubbleButton: UIButton!
    @IBOutlet var resetButton: UIButton!
    
    let messages: [String] = [
        "userName님 오늘도 좋은 아침이에요~!",
        "userName님, 어제보다 더 멋져요!",
        "userName님, 잘 먹고 잘 쉬었나요?",
        "userName님 덕분에 힘이 나요!",
        "userName님, 같이 산책 가요~!",
        "userName님, 포기하지 말아요!",
        "userName님, 항상 응원하고 있어요!",
        "userName님! 웃는 얼굴이 최고예요!",
        "userName님, 잠깐 쉬어가도 괜찮아요.",
        "userName님! 오늘도 화이팅이에요!",
        "userName님, 함께여서 행복해요!",
        "userName님, 고마운 하루였어요!",
        "userName님, 좋은 꿈 꾸세요~!",
        "userName님, 물 많이 마셨어요?",
        "userName님, 작은 걸음도 멋져요!",
        "userName님, 나랑 놀아줄 거죠?",
        "userName님! 실수해도 괜찮아요!",
        "userName님, 나 안 보고 싶었나요?",
        "userName님, 덕분에 오늘도 웃어요!",
        "userName님, 내일도 함께해요~!"
    ]
    
    private var level = 1 {
        didSet {
            if level < 10 {
                damagochiImage.image = UIImage(named: "2-\(level)")
            }
            else if level >= 10 {
                damagochiImage.image = UIImage(named: "2-9")
            }
        }
    }
    
    private var riceCount = 0 {
        didSet {
            UserDefaultsManager.riceCount = riceCount
            level = getUpdatedLevel()
            stateLabel.text = getUpdatedStateLabel()
        }
    }
    
    private var waterCount = 0{
        didSet {
            UserDefaultsManager.waterCount = waterCount
            level = getUpdatedLevel()
            stateLabel.text = getUpdatedStateLabel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UserDefaults 에 저장한 데이터 로드
        fetch()
        
        // 첫 실행 체크
        // property wrapper
        if !UserDefaultsManager.isFirstOpenApp {
            print("첫 실행")
            UserDefaultsManager.isFirstOpenApp = true
        }
        
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNavigationBarUI()
        damagochiSpeechLabel.text = getRandomMessage()
    }
    
    // MARK: - Action
    @IBAction func riceButtonTapped(_ sender: UIButton) {
        let text = riceTextField.text!
        
        guard !text.isEmpty else {
            giveFood(amount: 1)
            damagochiSpeechLabel.text = getRandomMessage()
            return
        }
        
        // 숫자인지 문자인지 확인
        guard isNumber(text: text) else {
            print("숫자만 입력해주세요")
            return
        }
        
        if Int(text)! > 99 {
            print("99 초과! 밥 못줘여")
            return
        }
        else if Int(text)! <= 99 {
            giveFood(amount: Int(text)!)
        }
        else {
            print("올바른 숫자를 입력하지 않았어요")
            return
        }
        
        // 다마고치 메시지 랜덤 변경
        damagochiSpeechLabel.text = getRandomMessage()
    }
    @IBAction func waterButtonTapped(_ sender: UIButton) {
        let text = waterBubbleTextField.text!
        
        guard !text.isEmpty else {
            giveWater(amount: 1)
            damagochiSpeechLabel.text = getRandomMessage()
            return
        }
        
        // 숫자인지 문자인지 확인
        guard isNumber(text: text) else {
            print("숫자만 입력해주세요")
            return
        }
        
        if Int(text)! > 49 {
            print("49 초과! 물 못줘여")
            return
        }
        else if Int(text)! <= 49 {
            giveWater(amount: Int(text)!)
        }
        else {
            print("올바른 숫자를 입력하지 않았어요")
            return
        }
        
        // 다마고치 메시지 랜덤 변경
        damagochiSpeechLabel.text = getRandomMessage()
    }
    
    func isNumber(text: String) -> Bool {
        if Int(text) == nil { return false }
        return true
    }
    
    func giveFood(amount: Int) {
        riceCount = riceCount + amount
    }
    func giveWater(amount: Int) {
        waterCount = waterCount + amount
    }
    
    func getUpdatedLevel() -> Int {
        let level = Int((Double(riceCount) / 5 + Double(waterCount) / 2) / 10) + 1
        if level > 10 { return 10 }
        return level
    }
    func getUpdatedStateLabel() -> String {
        return "LV\(level) · 밥알 \(riceCount)개 · 물방울 \(waterCount)개"
    }
    func getRandomMessage() -> String {
        let message =  messages.randomElement() ?? "매세지가 없습니다"
        return message.replacingOccurrences(of: "userName", with: UserDefaultsManager.userName)
    }
    
    func fetch() {
        riceCount = UserDefaultsManager.riceCount
        waterCount = UserDefaultsManager.waterCount
    }
    
    @IBAction func resetCount(_ sender: UIButton) {
        riceCount = 0
        waterCount = 0
    }
    @IBAction func riceTextFieldKeyboardDown(_ sender: UITextField) {}
    @IBAction func waterTextFieldKeyboardDown(_ sender: UITextField) {}
    
    // MARK: - UI
    func setUI() {
        setBackgoundUI()
        setLabelUI()
        setNavigationBarUI()
        setButtonUI()
        setAllTextFieldUI()
        navigationBarTitle.backBarButtonItem?.title = "설정"
    }
    
    func setBackgoundUI() {
        view.backgroundColor = .second
    }
    func setLabelUI() {
        damagochiSpeechLabel.text = "다마고치가 하는말"
        damagochiSpeechLabel.font = .systemFont(ofSize: 15, weight: .medium)
        damagochiSpeechLabel.textColor = .primary
        damagochiSpeechLabel.textAlignment = .center
        damagochiSpeechLabel.numberOfLines = 0
        
        damagochiNameLabel.text = "방실방실 다마고치"
        damagochiNameLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        damagochiNameLabel.textColor = .primary
        damagochiNameLabel.textAlignment = .center
        damagochiNameLabel.layer.borderWidth = 1.0
        damagochiNameLabel.layer.borderColor = UIColor.primary.cgColor
        
        damagochiNameLabel.layer.cornerRadius = 5
        damagochiNameLabel.clipsToBounds = true
        
        stateLabel.text = "LV\(level) · 밥알 \(riceCount)개 · 물방울 \(waterCount)개"
        stateLabel.font = .systemFont(ofSize: 15, weight: .bold)
        stateLabel.textColor = .primary
        stateLabel.textAlignment = .center
        
    }
    func setNavigationBarUI() {
        navigationBarTitle.title = UserDefaultsManager.userName + "님의 다마고치"
    }
    func setButtonUI() {
        riceButton.setTitle("밥먹기", for: .normal)
        riceButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        riceButton.setTitleColor(.primary, for: .normal)
        riceButton.backgroundColor = .second
        riceButton.layer.borderColor = UIColor.primary.cgColor
        riceButton.layer.borderWidth = 2
        riceButton.layer.cornerRadius = 10
        riceButton.clipsToBounds = true
        riceButton.tintColor = .primary
        
        waterBubbleButton.setTitle("물먹기", for: .normal)
        waterBubbleButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        waterBubbleButton.setTitleColor(.primary, for: .normal)
        waterBubbleButton.backgroundColor = .second
        waterBubbleButton.layer.borderColor = UIColor.primary.cgColor
        waterBubbleButton.layer.borderWidth = 2
        waterBubbleButton.layer.cornerRadius = 10
        waterBubbleButton.clipsToBounds = true
        waterBubbleButton.tintColor = .primary
        
        resetButton.setTitle("밥, 물 초기화", for: .normal)
        resetButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        resetButton.setTitleColor(.primary, for: .normal)
        resetButton.backgroundColor = .second
        resetButton.layer.borderColor = UIColor.primary.cgColor
        resetButton.layer.borderWidth = 1
        resetButton.layer.cornerRadius = 15
        resetButton.clipsToBounds = true
    }
    func setAllTextFieldUI() {
        setTextFieldUI(textField: riceTextField, text: "밥주세용")
        setTextFieldUI(textField: waterBubbleTextField, text: "물주세용")
    }
    func setTextFieldUI(textField: UITextField, text: String) {
        textField.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        textField.backgroundColor = .second
        textField.font = .systemFont(ofSize: 15)
        textField.textColor = .primary
        
        textField.borderStyle = .none
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.primary.cgColor
        
        // 입력하는 부분 왼쪽에 간격 추가
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8, height: 0.0))
        textField.leftViewMode = .always
    }
}




