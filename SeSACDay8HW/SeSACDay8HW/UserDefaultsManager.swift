//
//  UserDefaultsManager.swift
//  SeSACDay8HW
//
//  Created by 정성희 on 7/9/25.
//

import Foundation

class UserDefaultsManager {
    
    @UserDefault(key: "riceCount", defaultValue: 0)
    static var riceCount: Int
    
    @UserDefault(key: "waterCount", defaultValue: 0)
    static var waterCount: Int
    
    @UserDefault(key: "isFirstOpenApp", defaultValue: false)
    static var isFirstOpenApp: Bool
    
    @UserDefault(key: "userName", defaultValue: "대장")
    static var userName: String
}

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T // 값이 없을때 뭐가 나오게 할것인가
    
    var wrappedValue: T {
        get { UserDefaults.standard.object(forKey: key) as? T ?? defaultValue }
        set { UserDefaults.standard.set(newValue, forKey: key) }
    }
}
