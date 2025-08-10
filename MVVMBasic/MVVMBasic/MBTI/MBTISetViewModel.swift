//
//  MBTISetViewModel.swift
//  MVVMBasic
//
//  Created by 정성희 on 8/11/25.
//

import Foundation

class MBTISetViewModel {
    // input - Parameter Signal
    var nickname: String? = "" {
        didSet {
            validateNickname()
        }
    }
    
    var mbtiSelect: MBTIButton = MBTIButton()
    var mbtiButtonList: [MBTIButton] = []
    
    // input  - Method Signal
    var checkMBTISignal = () {
        didSet {
            checkMBTI()
            updateMBTICount()
        }
    }
    
    // output
    var hintText: String = "" {
        didSet {
            fetchHintText?()
        }
    }
    
    var outputEResult: Bool = false {
        didSet {
            fetchEStatus?()
        }
    }
    
    var outputIResult: Bool = false {
        didSet {
            fetchIStatus?()
        }
    }
    
    var outputSResult: Bool = false {
        didSet {
            fetchSStatus?()
        }
    }
    
    var outputNResult: Bool = false {
        didSet {
            fetchNStatus?()
        }
    }
    
    var outputTResult: Bool = false {
        didSet {
            fetchTStatus?()
        }
    }
    
    var outputFResult: Bool = false {
        didSet {
            fetchFStatus?()
        }
    }
    
    var outputJResult: Bool = false {
        didSet {
            fetchJStatus?()
        }
    }
    
    var outputPResult: Bool = false {
        didSet {
            fetchPStatus?()
        }
    }
    
    var outputIsValideSetUpProfile = false {
        didSet {
            fetchCompleteStatus?()
        }
    }
    
    // closure
    var fetchHintText : (() -> ())?
    
    var fetchEStatus: (() -> ())?
    var fetchIStatus: (() -> ())?
    var fetchSStatus: (() -> ())?
    var fetchNStatus: (() -> ())?
    var fetchTStatus: (() -> ())?
    var fetchFStatus: (() -> ())?
    var fetchJStatus: (() -> ())?
    var fetchPStatus: (() -> ())?
    
    var fetchCompleteStatus: (() -> ())?
    
    // private property
    private var isOnCount = 0
    
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
            hintText = ""
            isValideNickname = false
            return
        }
        
        let (hasSpecial, specialChar) = isContainSpecialCharacter(text: nickname)
        guard !hasSpecial else {
            hintText = "닉네임에 \(specialChar ?? "")는 포함할 수 없어요."
            isValideNickname = false
            return
        }
        
        guard !isContainNumber(text: nickname) else {
            hintText = "닉네임에 숫자는 포함할 수 없어요."
            isValideNickname = false
            return
        }
        
        guard 2 <= nickname.count && nickname.count <= 9 else {
            hintText = "닉네임은 2글자 이상, 9글자 이하로 작성해주세요."
            isValideNickname = false
            return
        }

        hintText = "사용할 수 있는 닉네임이에요."
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
    
    private func checkMBTI() {
        guard let selectMBTI = mbtiSelect.label.text else { return }
        let selectMBTIType = MBTIType(rawValue: selectMBTI)
        guard let selectMBTIType else { return }
        let partnerMBTI = selectMBTIType.partner.rawValue
        
        var pickMbtiIsOn = false
        var partnerMbtiIsOn = false
        
        for item in mbtiButtonList {
            if selectMBTI == item.label.text! {
                pickMbtiIsOn = item.isOn
            }
            
            if partnerMBTI == item.label.text! {
                partnerMbtiIsOn = item.isOn
            }
        }
        
        let result = getResult(pickMbtiIsOn: pickMbtiIsOn, partnerMbtiIsOn: partnerMbtiIsOn)

        switch selectMBTIType {
        case .E:
            outputEResult = result.0
            outputIResult = result.1
        case .I:
            outputEResult = result.1
            outputIResult = result.0
            
        case .S:
            outputSResult = result.0
            outputNResult = result.1
        case .N:
            outputSResult = result.1
            outputNResult = result.0
            
        case .T:
            outputTResult = result.0
            outputFResult = result.1
        case .F:
            outputTResult = result.1
            outputFResult = result.0
            
            
        case .J:
            outputJResult = result.0
            outputPResult = result.1
        case .P:
            outputJResult = result.1
            outputPResult = result.0
        }
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
    
    private func updateMBTICount() {
        isOnCount = 0
        
        for item in mbtiButtonList {
            isOnCount += item.isOn ? 1 : 0
        }
        
        if isOnCount == 4 {
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
