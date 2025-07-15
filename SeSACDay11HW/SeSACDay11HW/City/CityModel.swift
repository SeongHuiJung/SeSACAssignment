//
//  CityModel.swift
//  SeSACDay11HW
//
//  Created by 정성희 on 7/15/25.
//

import Foundation

struct City: Codable {
    let cityName: String
    let cityEnglishName: String
    let cityExplain: String
    let cityImage: String
    let domesticTravel: Bool
    
    enum CodingKeys: String, CodingKey {
        case cityName = "city_name"
        case cityEnglishName = "city_english_name"
        case cityExplain = "city_explain"
        case cityImage = "city_image"
        case domesticTravel = "domestic_travel"
    }
}
