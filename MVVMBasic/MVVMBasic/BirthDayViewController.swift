//
//  BirthDayViewController.swift
//  MVVMBasic
//
//  Created by Finn on 8/7/25.
//

import UIKit
import SnapKit

enum DateType: String, CaseIterable {
    case year
    case month
    case day
    
    var unit: String {
        switch self {
        case .year: "년"
        case .month: "월"
        case .day: "일"
        }
    }
}

class BirthDayViewController: UIViewController {
    
    var year: Int?
    var month: Int?
    var day: Int?
    
    let yearTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "년도를 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let yearLabel: UILabel = {
        let label = UILabel()
        label.text = "년"
        return label
    }()
    let monthTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "월을 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let monthLabel: UILabel = {
        let label = UILabel()
        label.text = "월"
        return label
    }()
    let dayTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "일을 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "일"
        return label
    }()
    let resultButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle( "클릭", for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "여기에 결과를 보여주세요"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        
        resultButton.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
    }
    
    func configureHierarchy() {
        view.addSubview(yearTextField)
        view.addSubview(yearLabel)
        view.addSubview(monthTextField)
        view.addSubview(monthLabel)
        view.addSubview(dayTextField)
        view.addSubview(dayLabel)
        view.addSubview(resultButton)
        view.addSubview(resultLabel)
    }
    
    func configureLayout() {
        yearTextField.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        yearLabel.snp.makeConstraints { make in
            make.centerY.equalTo(yearTextField)
            make.leading.equalTo(yearTextField.snp.trailing).offset(12)
        }
        
        monthTextField.snp.makeConstraints { make in
            make.top.equalTo(yearTextField.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        monthLabel.snp.makeConstraints { make in
            make.centerY.equalTo(monthTextField)
            make.leading.equalTo(monthTextField.snp.trailing).offset(12)
        }
        
        dayTextField.snp.makeConstraints { make in
            make.top.equalTo(monthTextField.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        dayLabel.snp.makeConstraints { make in
            make.centerY.equalTo(dayTextField)
            make.leading.equalTo(dayTextField.snp.trailing).offset(12)
        }
        
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(dayTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(resultButton.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func resultButtonTapped() {
        view.endEditing(true)
        
        guard let yearText = yearTextField.text else { return }
        year = setDateValue(text: yearText, type: DateType.year, min: 1, max: Int.max)
        
        guard year != nil, let monthText = monthTextField.text else { return }
        month = setDateValue(text: monthText, type: DateType.month, min: 1, max: 12)
        
        guard month != nil, let dayText = dayTextField.text else { return }
        day = setDateValue(text: dayText, type: DateType.day, min: 1, max: 31)
        
        guard let year, let month, let day else { return }
        
        do {
            let dDay = try checkValidateDate(year: year, month: month, day: day)
            if dDay > 0 {
                resultLabel.text = "오늘은 \(year)년 \(month)월 \(day)일로부터 \(dDay)일 지났어요 🍀"
            } else if dDay < 0 {
                resultLabel.text = "\(year)년 \(month)월 \(day)일까지 \(-dDay)일 남았어요 🍀"
            } else {
                resultLabel.text = "오늘은 지정하신 \(year)년 \(month)월 \(day)일 이에요 🍀"
            }
            
        } catch {
            makeAlert(message: "\(year)년 \(month)월 \(day)일은 존재하지 않는 날이에요")
        }
    }
    
    func setDateValue(text: String, type: DateType, min: Int, max: Int) -> Int? {
        let result = checkIsValidInt(text: text, type: type)
        let isInt = result.0
        let value = result.1
        
        if isInt {
            return checkIsValidRangeAndReturn(value: value, min: min, max: max, type: type)
        }
        return nil
    }
    
    func checkIsValidInt(text: String, type: DateType) -> (Bool, Int) {
        do {
            let value = try ErrorManager.shared.validateUserInput(text: text, transferType: Int.self)
            return (true, value)
        } catch {
            switch error {
            case .EmptyString:    makeAlert(message: "\(type.rawValue) 값이 비어 있습니다")
            case .haveWhiteSpace: makeAlert(message: "\(type.rawValue) 값에 띄어쓰기를 포함할 수 없습니다")
            case .isNotInt:       makeAlert(message: "입력한 \(type.rawValue) 값이 정수가 아닙니다")
            default:              makeAlert(message: "입력한 \(type.rawValue) 값이 올바른 타입이 아닙니다")
            }
            return (false, 0)
        }
    }
    
    func checkIsValidRangeAndReturn(value: Int, min: Int, max: Int, type: DateType) -> Int? {
        do {
            try ErrorManager.shared.validateNumberRange(value: value, min: min, max: max)
            return value
        } catch {
            switch error {
            case .lowerTHanMinimum: makeAlert(message: "\(type.rawValue)는 \(min)\(type.unit) 부터 입력할 수 있어요")
            case .upperTHanMaximum: makeAlert(message: "\(type.rawValue)는 \(max)\(type.unit) 까지만 입력할 수 있어요")
            }
            return nil
        }
    }
    
    func checkValidateDate(year: Int, month: Int, day: Int) throws(DateError) -> Int {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ko_KR")
        let startDateComponents = DateComponents(year: year, month: month, day: day)
        guard let startDate = calendar.date(from: startDateComponents) else {
            throw DateError.nonExistentDate
        }

        let offsetComps = Calendar.current.dateComponents([.day], from: startDate, to: Date())
        guard let dDay = offsetComps.day else { throw DateError.nonExistentDate }
        
        return dDay
    }
}
