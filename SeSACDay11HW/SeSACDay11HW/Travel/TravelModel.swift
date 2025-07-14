//
//  TravelModel.swift
//  SeSACDay11HW
//
//  Created by 정성희 on 7/12/25.
//

import Foundation

// var 가 아닌 let으로..
// 옵셔널 붙이기
// travel_image 같이 서버에서 주는 데이터 변수명이 카멜케이스가 아니라면 프로토콜을 이용해서 보완해주기?
struct Travel {
    var title: String
    var description: String?
    var travel_image: String?
    var grade: Double?
    var save: Int?
    var like: Bool?
    var ad: Bool
}
