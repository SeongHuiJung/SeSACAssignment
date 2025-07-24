//
//  LottoNum.swift
//  NetworkProject
//
//  Created by 정성희 on 7/24/25.
//

import Foundation
struct Lotto: Codable {
    let date: String?
    let num1: Int?
    let num2: Int?
    let num3: Int?
    let num4: Int?
    let num5: Int?
    let num6: Int?
    let bonusNum: Int?
    let returnValue: String?
    
    var numList: [Int?] {
        [num1, num2, num3, num4, num5]
    }
    
    enum CodingKeys: String, CodingKey {
        case date = "drwNoDate"
        case num1 = "drwtNo1"
        case num2 = "drwtNo2"
        case num3 = "drwtNo3"
        case num4 = "drwtNo4"
        case num5 = "drwtNo5"
        case num6 = "drwtNo6"
        case bonusNum = "bnusNo"
        case returnValue = "returnValue"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decodeIfPresent(String.self, forKey: .date)
        self.num1 = try container.decodeIfPresent(Int.self, forKey: .num1)
        self.num2 = try container.decodeIfPresent(Int.self, forKey: .num2)
        self.num3 = try container.decodeIfPresent(Int.self, forKey: .num3)
        self.num4 = try container.decodeIfPresent(Int.self, forKey: .num4)
        self.num5 = try container.decodeIfPresent(Int.self, forKey: .num5)
        self.num6 = try container.decodeIfPresent(Int.self, forKey: .num6)
        self.bonusNum = try container.decodeIfPresent(Int.self, forKey: .bonusNum)
        self.returnValue = try container.decodeIfPresent(String.self, forKey: .returnValue)
    }
}
