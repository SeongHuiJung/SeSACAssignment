//
//  EmotionViewController.swift
//  SeSACDay2HW
//
//  Created by 정성희 on 7/1/25.
//

import UIKit

// 받은 피드백
// switch 쓸때 default 위험성 체크
// 반복되는 부분 collection 및 함수로 변경
// 반복되는 부분 dictionary 사용해보기

class EmotionViewController: UIViewController {
    
    var numberList = [0,0,0,0,0,0,0,0,0]
    
    @IBOutlet var countToggle: UISwitch!
    
    @IBOutlet var emotionButton1: UIButton!
    @IBOutlet var emotionButton2: UIButton!
    @IBOutlet var emotionButton3: UIButton!
    @IBOutlet var emotionButton4: UIButton!
    @IBOutlet var emotionButton5: UIButton!
    @IBOutlet var emotionButton6: UIButton!
    @IBOutlet var emotionButton7: UIButton!
    @IBOutlet var emotionButton8: UIButton!
    @IBOutlet var emotionButton9: UIButton!
    
    @IBOutlet var emotionLabel1: UILabel!
    @IBOutlet var emotionLabel2: UILabel!
    @IBOutlet var emotionLabel3: UILabel!
    @IBOutlet var emotionLabel4: UILabel!
    @IBOutlet var emotionLabel5: UILabel!
    @IBOutlet var emotionLabel6: UILabel!
    @IBOutlet var emotionLabel7: UILabel!
    @IBOutlet var emotionLabel8: UILabel!
    @IBOutlet var emotionLabel9: UILabel!
    
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
            case 1:
                numberList[0] = randomNumber
                emotionLabel1.text = "행복해 \(numberList[0])"
            case 2:
                numberList[1] = randomNumber
                emotionLabel2.text = "사랑해 \(numberList[1])"
            case 3:
                numberList[2] = randomNumber
                emotionLabel3.text = "좋아해 \(numberList[2])"
            case 4:
                numberList[3] = randomNumber
                emotionLabel4.text = "당황해 \(numberList[3])"
            case 5:
                numberList[4] = randomNumber
                emotionLabel5.text = "속상해 \(numberList[4])"
            case 6:
                numberList[5] = randomNumber
                emotionLabel6.text = "우울해 \(numberList[5])"
            case 7:
                numberList[6] = randomNumber
                emotionLabel7.text = "심심해 \(numberList[6])"
            case 8:
                numberList[7] = randomNumber
                emotionLabel8.text = "피곤해 \(numberList[7])"
            case 9:
                numberList[8] = randomNumber
                emotionLabel9.text = "배고파 \(numberList[8])"
            default: break
            }
        }
        
        else {
            switch sender.tag {
            case 1:
                numberList[0] = numberList[0] + 1
                emotionLabel1.text = "행복해 \(numberList[0])"
            case 2:
                numberList[1] = numberList[1] + 1
                emotionLabel2.text = "사랑해 \(numberList[1])"
            case 3:
                numberList[2] = numberList[2] + 1
                emotionLabel3.text = "좋아해 \(numberList[2])"
            case 4:
                numberList[3] = numberList[3] + 1
                emotionLabel4.text = "당황해 \(numberList[3])"
            case 5:
                numberList[4] = numberList[4] + 1
                emotionLabel5.text = "속상해 \(numberList[4])"
            case 6:
                numberList[5] = numberList[5] + 1
                emotionLabel6.text = "우울해 \(numberList[5])"
            case 7:
                numberList[6] = numberList[6] + 1
                emotionLabel7.text = "심심해 \(numberList[6])"
            case 8:
                numberList[7] = numberList[7] + 1
                emotionLabel8.text = "피곤해 \(numberList[7])"
            case 9:
                numberList[8] = numberList[8] + 1
                emotionLabel9.text = "배고파 \(numberList[8])"
            default: break
            }
        }
        
        
    }
    
    // MARK: - UI setting
    func setEmotionUI() {
        emotionButton1.setImage(UIImage(named: "mono_slime1"), for: .normal)
        emotionButton2.setImage(UIImage(named: "mono_slime2"), for: .normal)
        emotionButton3.setImage(UIImage(named: "mono_slime3"), for: .normal)
        emotionButton4.setImage(UIImage(named: "mono_slime4"), for: .normal)
        emotionButton5.setImage(UIImage(named: "mono_slime5"), for: .normal)
        emotionButton6.setImage(UIImage(named: "mono_slime6"), for: .normal)
        emotionButton7.setImage(UIImage(named: "mono_slime7"), for: .normal)
        emotionButton8.setImage(UIImage(named: "mono_slime8"), for: .normal)
        emotionButton9.setImage(UIImage(named: "mono_slime9"), for: .normal)
        
        emotionLabel1.text = "행복해"
        emotionLabel2.text = "사랑해"
        emotionLabel3.text = "좋이해"
        emotionLabel4.text = "당황해"
        emotionLabel5.text = "속상해"
        emotionLabel6.text = "우울해"
        emotionLabel7.text = "심심해"
        emotionLabel8.text = "피곤해"
        emotionLabel9.text = "배고파"
        
        emotionButton1.tag = 1
        emotionButton2.tag = 2
        emotionButton3.tag = 3
        emotionButton4.tag = 4
        emotionButton5.tag = 5
        emotionButton6.tag = 6
        emotionButton7.tag = 7
        emotionButton8.tag = 8
        emotionButton9.tag = 9
    }
    func setToggleUI() {
        countToggle.isOn = false
    }
    
}
