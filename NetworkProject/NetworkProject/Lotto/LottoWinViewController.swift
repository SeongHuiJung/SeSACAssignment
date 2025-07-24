//
//  LottoWinViewController.swift
//  NetworkProject
//
//  Created by 정성희 on 7/23/25.
//

import UIKit
import Alamofire

class LottoWinViewController: UIViewController {

    let lastRoundOf20250719 = 1181
    var currentRound = 0
    var lottoNumRange = Array(1...45)
    
    lazy var textField = {
        let textField = CustomTextField()
        textField.inputView = pickerView
        
        return textField
    }()
    
    var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()

    let infoLabel = {
        let label = CustomUILabel(text: "당첨번호 안내", alignment: .left, size: 12)
        return label
    }()
    
    let dateLabel = {
        let label = CustomUILabel(text: "2020-05-30 추첨", textColor: .lightGray, alignment: .left, size: 11)
        return label
    }()
    
    let lineView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let roundLabel = {
        let label = CustomUILabel(text: "888회", textColor: .blue, alignment: .left, size: 22, weight: .bold)
        return label
    }()
    
    let resultLabel = {
        let label = CustomUILabel(text: "당첨결과", alignment: .left, size: 22, weight: .bold)
        return label
    }()
    
    let labelStackView = {
        let stackView = CustomStackViewHorizontal()
        return stackView
    }()
    
    let lottoWinNumberStackView = {
        let stackView = CustomStackViewHorizontal()
        return stackView
    }()
    
    let allLottoStackView = {
        let stackView = CustomStackViewHorizontal()
        stackView.spacing = 20
        return stackView
    }()
    
    let lottoWinViewList: [LottoWinView] = [{
        let view = LottoWinView(text: "6", backgroundColor: .systemYellow)
        return view
    }(),{
        let view = LottoWinView(text: "14", backgroundColor: .systemBlue)
        return view
    }(),{
        let view = LottoWinView(text: "16", backgroundColor: .systemBlue)
        return view
    }(),{
        let view = LottoWinView(text: "21", backgroundColor: .systemRed)
        return view
    }(),{
        let view = LottoWinView(text: "27", backgroundColor: .systemRed)
        return view
    }(),{
        let view = LottoWinView(text: "37", backgroundColor: .systemGray3)
        return view
    }(),]
    
    let additionalWinView = {
        let view = LottoWinView(text: "40", backgroundColor: .systemGray3)
        return view
    }()
    
    let addLabel = {
        let label = CustomUILabel(text: "+", alignment: .center, size: 15)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        
        // 가장 최신 회차의 로또 값 로드
        getLatestRound { latestRound in
            self.currentRound = latestRound
            self.callRequestLottoNum(round: latestRound) { Lotto in
                if self.isValidLottoData(lotto: Lotto) {
                    self.fetchUI(lotto: Lotto, round: latestRound)
                }
            }
        }
    }
}

// MARK: - Logic
extension LottoWinViewController {
    
    func getLatestRound(completion: @escaping (Int)->()) {
        let myDateComponents = DateComponents(year: 2025, month: 7, day: 19)
        let startDate = Calendar.current.date(from: myDateComponents)!
        let dayInterval = Calendar.current.dateComponents([.day], from: startDate, to: Date()).day!
        
        let round = lastRoundOf20250719 + dayInterval / 7
        var resultRound = 0
        
        // 로또 api가 토요일 중 언제 업데이트 될 지 모르기 때문에 (토요일 저녁에 로또를 뽑음)
        // 우선 토요일 자정이 되면 현재 회차를 +1 하여 업데이트 시키되,
        // 업데이트 된 회차로 데이터를 받아오는 것에 성공하는지 확인하여 업데이트 된 회차가 옳은 값인지 확인하는 절차를 거친다
        isRoundInRange(round: round) { data in
            if data.returnValue == nil { resultRound = round - 1 }
            else if data.returnValue! == "fail" { resultRound = round - 1 }
            else if data.returnValue! == "success" { resultRound = round }

            completion(resultRound) // 최종적으로 결정된 최신 회차를 completion 으로 보냄
        }
    }
    
    func isRoundInRange(round: Int, completion: @escaping (Lotto)->()) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=" + String(round)
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Lotto.self) { response in
                switch response.result {
                case .success(let value):
                    completion(value)
                case .failure(let error):
                    print("fail", error)
                }
            }
    }
    
    // data get
    func callRequestLottoNum(round: Int, completion: @escaping (Lotto)->()) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=" + String(round)
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Lotto.self) { response in
                switch response.result {
                case .success(let value):
                    completion(value)
                case .failure(let error):
                    print("fail", error)
                }
            }
    }
    
    // 불러온 데이터 ui에 반영
    func updateLottoData(lotto: Lotto) {

        for i in 0..<lotto.numList.count {
            lottoWinViewList[i].label.text = String(lotto.numList[i]!)
        }

        additionalWinView.label.text = String(lotto.bonusNum!)
        dateLabel.text = lotto.date! + " 추첨"
    }
    
    // 불러온 데이터 nil 검사
    func isValidLottoData(lotto: Lotto) -> Bool {
        
        for i in 0..<lotto.numList.count {
            if lotto.numList[i] == nil { print("올바른 데이터를 받지 못했습니다"); return false }
        }
        guard lotto.bonusNum != nil else { print("올바른 데이터를 받지 못했습니다"); return false }
        guard lotto.date != nil else { print("올바른 데이터를 받지 못했습니다"); return false }
        
        return true
    }
    
    // 랜덤관련 함수
    func getRandomLottoNum() -> [Int] {
        lottoNumRange.shuffle()
        return Array(lottoNumRange[0...6])
    }
    
    // 랜덤관련 함수
    func setNewLottoNum(numList: [Int]) {
        for i in 0..<numList.count - 1 {
            lottoWinViewList[i].label.text = String(numList[i])
        }
        additionalWinView.label.text = String(numList[numList.count - 1])
    }
}

// MARK: - Picker Delegate
extension LottoWinViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currentRound
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row + 1) + "회차"
    }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        callRequestLottoNum(round: row + 1) { Lotto in
            if self.isValidLottoData(lotto: Lotto) {
                self.fetchUI(lotto: Lotto, round: row + 1)
            }
        }
    }
    
    func fetchUI(lotto: Lotto, round: Int) {
        self.updateLottoData(lotto: lotto)
        self.roundLabel.text = "\(round)회"
        self.textField.text = "\(round)회차"
    }
}

// MARK: - UI Protocol
extension LottoWinViewController: ViewDesignProtocol {
    func configureHierarchy() {
        [textField, infoLabel, dateLabel, lineView, labelStackView, allLottoStackView].forEach{ view.addSubview($0) }
        [roundLabel, resultLabel].forEach{ labelStackView.addArrangedSubview($0) }
        
        [lottoWinNumberStackView, addLabel, additionalWinView].forEach{ allLottoStackView.addArrangedSubview($0) }
        lottoWinViewList.forEach{ lottoWinNumberStackView.addArrangedSubview($0) }
    }
    
    func configureLayout() {
        textField.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide).inset(32)
            make.bottom.equalTo(lineView.snp.top).offset(-100)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.left.equalTo(lineView.snp.left)
            make.bottom.equalTo(lineView.snp.top).offset(-10)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.right.equalTo(lineView.snp.right)
            make.bottom.equalTo(lineView.snp.top).offset(-10)
        }
        
        lineView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(1)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(lineView.snp.bottom).offset(56)
        }
        
        allLottoStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(labelStackView.snp.bottom).offset(30)
        }
        
        // 로또 커스텀뷰 리스트
        lottoWinViewList.forEach { LottoWinView in
            LottoWinView.snp.makeConstraints { make in
                make.height.equalTo(40)
                make.width.equalTo(40)
            }
        }
        
        additionalWinView.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
    }
    
    func configureView() {
        view.backgroundColor = .white
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }
}
