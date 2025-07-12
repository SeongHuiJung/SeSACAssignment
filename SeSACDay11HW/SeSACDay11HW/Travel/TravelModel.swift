//
//  TravelModel.swift
//  SeSACDay11HW
//
//  Created by 정성희 on 7/12/25.
//

import Foundation

//Travel(title: "하나우마 베이",
//       description: "아름다운 자연을 감상할 수 있는 스노쿨링 명소",
//       travel_image: "https://images.unsplash.com/photo-1539498508910-091b5e859b1d?q=80&w=3250&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
//       grade: 4.8,
//       save: 6932,
//       like: false,
//       ad: false),

struct Travel {
    let title: String
    let description: String?
    let travel_image: String?
    let grade: Double? // star
    let save: Int?
    let like: Bool?
    let ad: Bool
}
