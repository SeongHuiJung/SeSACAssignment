//
//  MovieRank.swift
//  TamagotchiGame
//
//  Created by 정성희 on 8/25/25.
//

import Foundation
struct MovieRank: Codable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Codable {
    let movieData: [BoxOffice]
    
    enum CodingKeys: String, CodingKey {
        case movieData = "dailyBoxOfficeList"
    }
}

struct BoxOffice: Codable {
    let name: String?
    let openDate: String?
    let rank: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "movieNm"
        case openDate = "openDt"
        case rank = "rank"
    }
}
