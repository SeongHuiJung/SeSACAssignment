//
//  MovieRank.swift
//  TamagotchiGame
//
//  Created by 정성희 on 8/25/25.
//

import Foundation
struct MovieRank: Codable {
    let boxOfficeResult: BoxOfficeResult
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.boxOfficeResult = try container.decode(BoxOfficeResult.self, forKey: .boxOfficeResult)
    }
}

struct BoxOfficeResult: Codable {
    let movieData: [BoxOffice]
    
    enum CodingKeys: String, CodingKey {
        case movieData = "dailyBoxOfficeList"
    }
    
    init(movieData: [BoxOffice]) {
        self.movieData = movieData
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
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.openDate = try container.decodeIfPresent(String.self, forKey: .openDate)
        self.rank = try container.decodeIfPresent(String.self, forKey: .rank)
    }
}
