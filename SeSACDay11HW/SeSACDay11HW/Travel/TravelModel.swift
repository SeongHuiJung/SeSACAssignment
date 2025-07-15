//
//  TravelModel.swift
//  SeSACDay11HW
//
//  Created by 정성희 on 7/12/25.
//

import Foundation

// travel_image 같이 서버에서 주는 데이터 변수명이 카멜케이스가 아니라면 프로토콜을 이용해서 보완해주기?
struct Travel {
    let title: String
    let description: String?
    let travel_image: String?
    let grade: Double?
    let save: Int?
    var like: Bool?
    let ad: Bool
}
