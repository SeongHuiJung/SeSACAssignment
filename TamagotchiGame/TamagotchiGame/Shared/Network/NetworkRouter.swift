//
//  NetworkRouter.swift
//  TamagotchiGame
//
//  Created by 정성희 on 8/26/25.
//

import Foundation
import Alamofire

struct MovieParameter {
    let key: String
    let targetDt: String
}

struct LottoParameter {
    let method: String
    let drwNo: String
}

enum NetworkRouter {
    case lotto(param: LottoParameter)
    case trendMovie(param: MovieParameter)
    
    var URL: String {
        switch self {
        case .lotto: BaseUrl.lotto + Endpoint.lotto
        case .trendMovie: BaseUrl.movie + Endpoint.trendMovie
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .lotto: .get
        case .trendMovie: .get
        }
    }
    
    var parameter: Parameters {
        switch self {
        case .lotto(let params):
            return ["method": params.method,
                   "drwNo": params.drwNo]
        case .trendMovie(let params):
            return ["key": params.key,
                    "targetDt": params.targetDt]
        }
    }
}
