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

    @UserDefault(key: "userName", defaultValue: "대장")
    static var userName: String
    
    @UserDefault(key: "tamagotchiTypeIndex", defaultValue: 0)
    static var tamagotchiTypeIndex: Int
    
    @UserDefault(key: "tamagotchiLevel", defaultValue: 0)
    static var tamagotchiLevel: Int
}

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get { UserDefaults.standard.object(forKey: key) as? T ?? defaultValue }
        set { UserDefaults.standard.set(newValue, forKey: key) }
    }
}
