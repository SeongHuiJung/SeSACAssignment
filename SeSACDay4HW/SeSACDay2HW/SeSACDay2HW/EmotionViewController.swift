//
//  EmotionViewController.swift
//  SeSACDay2HW
//
//  Created by 정성희 on 7/1/25.
//

import UIKit

// -- 받은 피드백 --
// switch 쓸때 default 위험성 체크 -> check
// 반복되는 부분 collection 및 함수로 변경 -> check
// dictionary 사용해보기 -> check

class EmotionViewController: UIViewController {
    
    var numberList = [0,0,0,0,0,0,0,0,0]
    
    @IBOutlet var countToggle: UISwitch!
    @IBOutlet var emotionButton: [UIButton]!
    @IBOutlet var emotionLabel: [UILabel]!
    
    let emotionList = [0: "행복해", 1: "사랑해", 2: "좋아해", 3: "당황해", 4: "속상해", 5: "우울해", 6: "심심해", 7: "피곤해", 8: "배고파"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setEmotionUI()
        setToggleUI()
    }
    
    // 스위치 off : 버튼 클릭시 해당 요소에 랜덤값 지정
    // 스위치 on : 버튼 클릭시 해당 요소에 1 더함
    @IBAction func emotionButtonTapped(_ sender: UIButton) {
        
        if !countToggle.isOn {
            let randomNumber = Int.random(in: 1...100)
            numberList[sender.tag] = randomNumber
            emotionLabel[sender.tag].text = "\(emotionList[sender.tag]!) \( numberList[sender.tag])"
        }
        else {
            numberList[sender.tag] = numberList[sender.tag] + 1
            emotionLabel[sender.tag].text = "\(emotionList[sender.tag]!) \(numberList[sender.tag])"
        }
    }
    
    // MARK: - UI setting
    func setEmotionUI() {
        print(emotionList)
        for i in 0..<emotionButton.count {
            emotionButton[i].setImage(UIImage(named: "mono_slime\(i + 1)"), for: .normal)
            emotionLabel[i].text = emotionList[i]
            print(emotionLabel[i].text)
            print("emotionList[i]: \(emotionList[i])")
            
            emotionButton[i].tag = i
        }
    }
    func setToggleUI() {
        countToggle.isOn = false
    }
}
