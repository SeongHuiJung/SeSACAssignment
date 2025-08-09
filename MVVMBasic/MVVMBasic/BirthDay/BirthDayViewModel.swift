//
//  BirthDayViewModel.swift
//  MVVMBasic
//
//  Created by 정성희 on 8/9/25.
//

import Foundation

class BirthDayViewModel {
    // input - Parameter Signal
    var inputYearText: String?
    var inputMonthText: String?
    var inputDayText: String?
    
    // input  - Method Signal
    var inputCheckBirthDaySignal = () {
        didSet {
            guard let inputYearText else { return }
            year = validateValue(text: inputYearText, type: DateType.year, min: 1, max: Int.max)
            
            guard year != nil, let inputMonthText else { return }
            month = validateValue(text: inputMonthText, type: DateType.month, min: 1, max: 12)
            
            guard month != nil, let inputDayText else { return }
            day = validateValue(text: inputDayText, type: DateType.day, min: 1, max: 31)
            
            guard let year, let month, let day else { return }
            validateDate(year: year, month: month, day: day)
        }
    }
    
    
    // output
    var outputResultText = "" {
        didSet {
            fetchUI?()
        }
    }
    
    var outputErrorText = "" {
        didSet {
            showErrorALert?()
        }
    }

    // closure
    var fetchUI: (() -> ())?
    var showErrorALert: (() -> ())?
    
    private var year: Int?
    private var month: Int?
    private var day: Int?
}

extension BirthDayViewModel {
    private func validateValue(text: String, type: DateType, min: Int, max: Int) -> Int? {
        let result = checkIsValidInt(text: text, type: type)
        let isInt = result.0
        let value = result.1
        
        if isInt {
            return checkIsValidRangeAndReturn(value: value, min: min, max: max, type: type)
        }
        return nil
    }
    
    private func validateDate(year: Int, month: Int, day: Int) {
        do {
            let dDay = try checkValidateDate(year: year, month: month, day: day)
            if dDay > 0 {
                outputResultText = "오늘은 \(year)년 \(month)월 \(day)일로부터 \(dDay)일 지났어요 🍀"
            } else if dDay < 0 {
                outputResultText = "\(year)년 \(month)월 \(day)일까지 \(-dDay)일 남았어요 🍀"
            } else {
                outputResultText = "오늘은 지정하신 \(year)년 \(month)월 \(day)일 이에요 🍀"
            }
            
        } catch {
            outputErrorText = "\(year)년 \(month)월 \(day)일은 존재하지 않는 날이에요"
        }
    }
    
    private func checkIsValidInt(text: String, type: DateType) -> (Bool, Int) {
        do {
            let value = try ErrorManager.shared.validateUserInput(text: text, transferType: Int.self)
            return (true, value)
        } catch {
            switch error {
            case .EmptyString:    outputErrorText = "\(type.rawValue) 값이 비어 있습니다"
            case .haveWhiteSpace: outputErrorText = "\(type.rawValue) 값에 띄어쓰기를 포함할 수 없습니다"
            case .isNotInt:       outputErrorText = "입력한 \(type.rawValue) 값이 정수가 아닙니다"
            default:              outputErrorText = "입력한 \(type.rawValue) 값이 올바른 타입이 아닙니다"
            }
            return (false, 0)
        }
    }
    
    private func checkIsValidRangeAndReturn(value: Int, min: Int, max: Int, type: DateType) -> Int? {
        do {
            try ErrorManager.shared.validateNumberRange(value: value, min: min, max: max)
            return value
        } catch {
            switch error {
            case .lowerTHanMinimum: outputErrorText = "\(type.rawValue)는 \(min)\(type.unit) 부터 입력할 수 있어요"
            case .upperTHanMaximum: outputErrorText = "\(type.rawValue)는 \(max)\(type.unit) 까지만 입력할 수 있어요"
            }
            return nil
        }
    }
    
    private func checkValidateDate(year: Int, month: Int, day: Int) throws(DateError) -> Int {
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
