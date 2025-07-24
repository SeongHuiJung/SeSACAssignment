//
//  LottoWinViewController.swift
//  NetworkProject
//
//  Created by 정성희 on 7/23/25.
//

import UIKit

class LottoWinViewController: UIViewController {

    let lottoRoundList = Array(1...1181)
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
    }
}

// MARK: - Logic
extension LottoWinViewController {
    func getRandomLottoNum() -> [Int] {
        lottoNumRange.shuffle()
        return Array(lottoNumRange[0...6])
    }
    
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
        return lottoRoundList.count
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(lottoRoundList[row]) + "회차"
    }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let numList = getRandomLottoNum().sorted()
        setNewLottoNum(numList: numList)
        
        roundLabel.text = "\(lottoRoundList[row])회"
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
