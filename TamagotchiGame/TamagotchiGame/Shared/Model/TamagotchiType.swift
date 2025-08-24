//
//  ss.swift
//  TamagotchiGame
//
//  Created by 정성희 on 8/25/25.
//

import Foundation

enum TamagotchiType {
    case tingling(level: Int)
    case smile(level: Int)
    case twinkle(level: Int)
    case none
    
    var krName: String {
        switch self {
        case .tingling: "따끔따끔 다마고치"
        case .smile: "방실방실 다마고치"
        case .twinkle: "반짝반짝 다마고치"
        case .none: "준비중이에요"
        }
    }
    
    var index: Int {
        switch self {
        case .tingling: 1
        case .smile: 2
        case .twinkle: 3
        case .none: -1
        }
    }
    
    var imageName: String {
        switch self {
        case .tingling(let level),
                .smile(let level),
                .twinkle(let level): "\(self.index)-\(level)"
        case .none: "noImage"
        }
    }
    
    var description: String {
        switch self {
        case .tingling: "저는 따끔따끔 다마고치에요\n만질때는 따끔따끔하니 조심해주세요"
        case .smile: "저는 방실방실 다마고치에요\n웃게 만들어드릴게요~~"
        case .twinkle: "저는 반짝반짝 다마고치에요\n반짝반짝 빛나용"
        case .none: "준비중이에요"
        }
    }
}
