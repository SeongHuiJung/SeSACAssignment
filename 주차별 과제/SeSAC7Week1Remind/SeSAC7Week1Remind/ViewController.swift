//
//  ViewController.swift
//  SeSAC7Week1Remind
//
//  Created by Jack on 7/3/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func zodiacSignsTapped(_ sender: UIButton) {
        getZodiacSign(month: Int.random(in: 1...12))
    }
    
    func getZodiacSign(month: Int) {
        let zodiacList = ["염소", "물병", "물고기", "양", "황소", "쌍둥이", "게", "사자", "처녀", "천칭", "전갈", "사수"]
        resultLabel.text = "\(month)월은 \(zodiacList[month - 1])자리입니다."
    }
    
    @IBAction func recommandGameJob(_ sender: UIButton) {
        let strength = Int.random(in: 1...100)
        let agility = Int.random(in: 1...100)
        getRecommandGameJob(strength: strength, agility: agility)
    }
    
    func getRecommandGameJob(strength: Int, agility: Int) {
        if strength > agility { resultLabel.text = "strength(힘)이 가장 높으니 전사를 추천드립니다." }
        else if strength < agility { resultLabel.text = "agility(민첩)이 가장 높으니 도적을 추천드립니다." }
        else if strength == agility { resultLabel.text = "힘과 민첩이 같으니 마법사를 추천드립니다." }
        else { resultLabel.text = "직업 정보가 존재하지 않아요" }
    }
    
    @IBAction func recommandClothing(_ sender: UIButton) {
        let temp = Int.random(in: -30...50)
        let rain = Bool.random()
        
        getRecommandClothing(temperature: temp, isRaining: rain)
    }
    
    func getRecommandClothing(temperature: Int, isRaining: Bool) {
        switch temperature {
        case ...10:
            if isRaining { resultLabel.text = """
                            지금 온도가 \(temperature)도 이니 페딩을 입으세요.
                            눈이 오니 우산을 챙겨주세요.
                            낭만있게 눈을 맞아주셔도 됩니다.
                             
                            """ }
            else { resultLabel.text = """
                                지금 온도가 \(temperature)도 이니 페딩을 입으세요.
                                눈이 오지 않으니 우산은 안챙겨도 됩니다. 
                                """ }
        case 10..<20:
            if isRaining { resultLabel.text = """
                            지금 온도가 \(temperature)도 이니 긴팔을 입으세요.
                            비가 오고 있으니 우산을 챙겨주세요.
                            """ }
            else { resultLabel.text = """
                                지금 온도가 \(temperature)도 이니 긴팔을 입으세요.
                                비가 오지 않으니 우산은 안챙겨도 됩니다.  
                                """ }
        case 20..<30:
            if isRaining { resultLabel.text = """
                            지금 온도가 \(temperature)도 이니 반팔을 입으세요.
                            비가 오고 있으니 우산을 챙겨주세요.
                            """ }
            else { resultLabel.text = """
                                지금 온도가 \(temperature)도 이니 반팔을 입으세요.
                                비가 오지 않으니 우산은 안챙겨도 됩니다.  
                                """ }
        case 30...:
            if isRaining { resultLabel.text = """
                            지금 온도가 \(temperature)도 이니 나가지 마세요.
                            비가 오고 있으니 우산을 챙겨주세요.
                            """ }
            else { resultLabel.text = """
                                지금 온도가 \(temperature)도 이니 나가지 마세요.
                                비가 오지 않으니 우산은 안챙겨도 됩니다.  
                                """ }
        default: resultLabel.text = "오류가 발생했습니다."
        }
    }
    
    @IBAction func evaluateGrade(_ sender: UIButton) {
        let data = [3, 27, 64, 89, 7, 12, 45, 78, 14, 29, 56, 92, 1, 33, 67, 85, 9, 21, 48, 76, 18, 41, 63, 94, 5, 30, 52, 87, 11, 26, 59, 81, 15, 37, 70, 96, 2, 34, 61, 83, 8, 23, 49, 90, 17, 39, 65, 98, 4, 28, 53, 79, 12, 36, 68, 91, 6, 31, 57, 84, 19, 42, 66, 95, 10, 25, 51, 88, 16, 38, 60, 97, 13, 32, 55, 82, 20, 44, 69, 93, 3, 29, 62, 86, 7, 35, 58, 80, 14, 40, 64, 99, 1, 24, 50, 77, 9, 33, 67, 92, 18, 46, 71, 85, 5, 27, 54, 89, 11, 39, 63, 96, 15, 34, 59, 81, 2, 30, 65, 94, 8, 41, 68, 87, 17, 37, 52, 90, 4, 26, 61, 83, 12, 43, 70, 98, 6, 28, 56, 79, 19, 45, 66, 91, 10, 32, 58, 84, 16, 40, 62, 95, 13, 25, 51, 88, 20, 38, 69, 97, 3, 31, 57, 82, 7, 36, 64, 93, 14, 29, 50, 86, 1, 42, 67, 80, 9, 34, 61, 99, 18, 27, 55, 92, 5, 39, 68, 85, 11, 33, 60, 94, 15, 46, 71]
        
        let sum = data.reduce(0,+)
        let count = data.count
        let evaluation = sum / count
        
        resultLabel.text = "\(count)명의 평균 점수는 \(evaluation)점입니다."
    }
    
    @IBAction func countFruits(_ sender: UIButton) {
        var dic : [String: Int] = [:]
        let fruits = ["체리", "딸기", "사과", "멜론", "망고", "오렌지", "오렌지", "키위", "딸기", "사과", "복숭아", "포도", "배", "바나나", "오렌지", "배", "포도", "참외", "사과", "블루베리", "오렌지", "오렌지", "바나나", "사과", "수박", "포도", "딸기", "체리", "사과", "자두", "멜론", "멜론", "수박", "파인애플", "참외", "참외", "바나나", "멜론", "사과", "사과", "자두", "딸기", "바나나", "석류", "라임", "키위", "자두", "사과", "오렌지", "자두", "레몬", "바나나", "사과", "수박", "체리", "사과", "블루베리", "딸기", "바나나", "수박", "체리", "사과", "복숭아", "수박", "참외", "오렌지", "바나나", "참외", "오렌지", "바나나", "체리", "딸기", "바나나", "감", "감", "키위", "자두", "포도", "파인애플", "포도", "사과", "포도", "블루베리", "포도", "바나나", "사과", "망고", "복숭아", "레몬", "사과", "자두", "복숭아", "포도", "오렌지", "오렌지", "수박", "망고", "사과", "블루베리", "감", "바나나", "딸기", "바나나"]
        
        fruits.forEach { dic[$0] = (dic[$0] ?? 0) + 1 }

        var text = ""

        for (key, value) in dic {
            text += "\(key): \(value), "
        }
        
        text.removeLast()
        text.removeLast()
        
        resultLabel.text = text
    }
}
