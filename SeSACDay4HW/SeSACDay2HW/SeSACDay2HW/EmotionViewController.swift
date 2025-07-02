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
            switch sender.tag {
            case 0:
                numberList[0] = randomNumber
                emotionLabel[0].text = "행복해 \(numberList[0])"
            case 1:
                numberList[1] = randomNumber
                emotionLabel[1].text = "사랑해 \(numberList[1])"
            case 2:
                numberList[2] = randomNumber
                emotionLabel[2].text = "좋아해 \(numberList[2])"
            case 3:
                numberList[3] = randomNumber
                emotionLabel[3].text = "당황해 \(numberList[3])"
            case 4:
                numberList[4] = randomNumber
                emotionLabel[4].text = "속상해 \(numberList[4])"
            case 5:
                numberList[5] = randomNumber
                emotionLabel[0].text = "우울해 \(numberList[5])"
            case 6:
                numberList[6] = randomNumber
                emotionLabel[6].text = "심심해 \(numberList[6])"
            case 7:
                numberList[7] = randomNumber
                emotionLabel[7].text = "피곤해 \(numberList[7])"
            case 8:
                numberList[8] = randomNumber
                emotionLabel[8].text = "배고파 \(numberList[8])"
            default:
                print("Error! 올바르지 않은 값입니다")
            }
        }
        
        else {
            switch sender.tag {
            case 0:
                numberList[0] = numberList[0] + 1
                emotionLabel[0].text = "행복해 \(numberList[0])"
            case 1:
                numberList[1] = numberList[1] + 1
                emotionLabel[1].text = "사랑해 \(numberList[1])"
            case 2:
                numberList[2] = numberList[2] + 1
                emotionLabel[2].text = "좋아해 \(numberList[2])"
            case 3:
                numberList[3] = numberList[3] + 1
                emotionLabel[3].text = "당황해 \(numberList[3])"
            case 4:
                numberList[4] = numberList[4] + 1
                emotionLabel[4].text = "속상해 \(numberList[4])"
            case 5:
                numberList[5] = numberList[5] + 1
                emotionLabel[0].text = "우울해 \(numberList[5])"
            case 6:
                numberList[6] = numberList[6] + 1
                emotionLabel[6].text = "심심해 \(numberList[6])"
            case 7:
                numberList[7] = numberList[7] + 1
                emotionLabel[7].text = "피곤해 \(numberList[7])"
            case 8:
                numberList[8] = numberList[8] + 1
                emotionLabel[8].text = "배고파 \(numberList[8])"
            default:
                print("Error! 올바르지 않은 값입니다")
            }
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
