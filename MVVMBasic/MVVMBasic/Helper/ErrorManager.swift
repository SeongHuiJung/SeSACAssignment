//
//  ErrorManager.swift
//  MVVMBasic
//
//  Created by 정성희 on 8/7/25.
//

import UIKit

enum NumberValidationError : Error {
    case EmptyString
    case haveWhiteSpace
    case isNotInt
    case isNotDouble
    case isNotValidType
}

enum NumberRangeError: Error {
    case lowerTHanMinimum
    case upperTHanMaximum
}

enum DateError: Error {
    case nonExistentDate
}

final class ErrorManager {
    static let shared = ErrorManager()
    private init() {}
    
    func validateUserInput<T: LosslessStringConvertible>(text: String, transferType: T.Type) throws(NumberValidationError) -> T {
        guard !(text.isEmpty) else { throw NumberValidationError.EmptyString }
        
        for char in text {
            if char == " " { throw NumberValidationError.haveWhiteSpace }
        }
        
        if T.self is Int.Type {
            guard let value = Int(text) else { throw NumberValidationError.isNotInt }
            return value as! T
        }
        
        else if T.self is Double.Type {
            guard let value = Double(text) else { throw NumberValidationError.isNotDouble }
            return value as! T
        }
        
        else {
            throw NumberValidationError.isNotValidType
        }
    }
    
    func validateNumberRange<T: Comparable>(value: T, min: T, max: T) throws(NumberRangeError) {
        guard value >= min else { throw NumberRangeError.lowerTHanMinimum }
        guard value <= max else { throw NumberRangeError.upperTHanMaximum }
    }
}

