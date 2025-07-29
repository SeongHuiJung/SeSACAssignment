//
//  APIError.swift
//  Shopping
//
//  Created by 정성희 on 7/29/25.
//

import Foundation

struct APIError: Codable {
    let errorCode: String
    let errorMessage: String
}
