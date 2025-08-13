//
//  MBTISetViewModel.swift
//  MVVMBasic
//
//  Created by 정성희 on 8/11/25.
//

import Foundation

class MBTISetViewModel {
    
    var inputMBTIData: [String: String] = [:]
    
    var inputIsOnCount = 0 {
        didSet {
            updateMBTIIsOnCount()
        }
    }
    // input - Parameter Signal
    var nickname: String? = "" {
        didSet {
            validateNickname()
        }
    }
    
    // 데이터 매개변수로 넣기
    // input  - Method Signal
    var checkMBTISignal = () {
        didSet {
            setMBTIPariIndex()
            updateMBTIIsOnData()
            
        }
    }
    
    // output
    var outputHintText: String = "" {
        didSet {
            fetchHintText?()
        }
    }
    
    var outputMBTIResult: ((Int, Bool), (Int, Bool)) = ((0,false),(0,false)) {
        didSet {
            fetchMBTIButtonStatus?()
        }
    }

    var outputIsValideSetUpProfile = false {
        didSet {
            fetchCompleteStatus?()
        }
    }
    
    // closure
    var fetchHintText : (() -> ())?
    var fetchMBTIButtonStatus: (() -> ())?
    var fetchCompleteStatus: (() -> ())?
    
    private var isValideNickname = false {
        didSet {
            checkisValideSetUpProfile()
        }
    }
    private var isValideMBTI = false {
        didSet {
            checkisValideSetUpProfile()
        }
    }
}

// MARK: - Logic
extension MBTISetViewModel {
    private func validateNickname() {
        guard let nickname = nickname else { return }
        
        guard nickname.count != 0 else {
            outputHintText = ""
            isValideNickname = false
            return
        }
        
        let (hasSpecial, specialChar) = isContainSpecialCharacter(text: nickname)
        guard !hasSpecial else {
            outputHintText = "닉네임에 \(specialChar ?? "")는 포함할 수 없어요."
            isValideNickname = false
            return
        }
        
        guard !isContainNumber(text: nickname) else {
            outputHintText = "닉네임에 숫자는 포함할 수 없어요."
            isValideNickname = false
            return
        }
        
        guard 2 <= nickname.count && nickname.count <= 9 else {
            outputHintText = "닉네임은 2글자 이상, 9글자 이하로 작성해주세요."
            isValideNickname = false
            return
        }
        
        outputHintText = "사용할 수 있는 닉네임이에요."
        isValideNickname = true
    }
    
    private func isContainSpecialCharacter(text: String) -> (Bool, String?) {
        let specialCharacterList = ["@", "#", "$", "%"]
        for char in specialCharacterList {
            if text.contains(char) {
                return (true, String(char))
            }
        }
        return (false, nil)
    }
    
    private func isContainNumber(text: String) -> Bool {
        for char in text {
            if Int(String(char)) != nil {
                return true
            }
        }
        return false
    }
    
    private func setMBTIPariIndex() {
        inputMBTIData["selectIndex"] = "\(MBTIType(rawValue: inputMBTIData["selectMBTI"]!)!.index)"
        
        // 파트너 mbti 찾기
        guard let partnerType = MBTIType(rawValue: inputMBTIData["selectMBTI"]!)?.partner else { return }
        inputMBTIData["partnerIndex"] = "\(partnerType.index)"
    }
    
    private func updateMBTIIsOnData() {
        let pickMbtiIsOn = Bool(inputMBTIData["selectIsOn"]!)! // 사용자가 선택한 mbti 의 현재 상태
        let partnerMbtiIsOn = Bool(inputMBTIData["partnerIsOn"]!)! // 사용자가 선택한 짝 mbti 의 현재 상태
        
        let result = getResult(pickMbtiIsOn: pickMbtiIsOn, partnerMbtiIsOn: partnerMbtiIsOn)
        
        outputMBTIResult = ((Int(inputMBTIData["selectIndex"]!)!, result.0),
                            (Int(inputMBTIData["partnerIndex"]!)!, result.1))
    }
    
    // E/I , N/S ... 각 짝끼리 라디오 기능 설정
    //  0 0 -> 둘다 false 인지 확인 후 클릭한거 true
    //  1 0 -> 파트너가 false 라면 -> 내꺼만 반대로하기
    //         파트너가 true 라면  -> 둘다 반대로
    private func getResult(pickMbtiIsOn: Bool, partnerMbtiIsOn: Bool) -> (Bool, Bool) {
        if !pickMbtiIsOn  && !partnerMbtiIsOn {
            return (true, false)
        }
        else if !partnerMbtiIsOn {
            return (false, false)
        }
        else if partnerMbtiIsOn {
            return (true, false)
        }
        else {
            return (false, false)
        }
    }
    
    private func updateMBTIIsOnCount() {
        
        if inputIsOnCount == 4 {
            isValideMBTI = true
        }
        else {
            isValideMBTI = false
        }
    }
    
    private func checkisValideSetUpProfile() {
        if isValideMBTI && isValideNickname && !outputIsValideSetUpProfile {
            outputIsValideSetUpProfile = true
        }
        else if (!isValideMBTI || !isValideNickname) && outputIsValideSetUpProfile {
            outputIsValideSetUpProfile = false
        }
    }
}

