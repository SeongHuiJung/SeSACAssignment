//
//  SearchMovieRankViewModel.swift
//  TamagotchiGame
//
//  Created by 정성희 on 8/26/25.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchMovieRankViewModel {
    struct Input {
        let textFieldReturnTapped: Observable<ControlProperty<String>.Element>
    }
    
    struct Output {
        let movieData: PublishRelay<[BoxOffice]>
        let alertData: PublishRelay<(title: String, message: String)>
    }
    
    init() {}
    
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        
        let movieData: PublishRelay<[BoxOffice]> = PublishRelay()
        let alertData: PublishRelay<(title: String, message: String)> = PublishRelay()
                        
        input.textFieldReturnTapped
            .distinctUntilChanged() // 0826 reveiw: indicator
            .filter {
                if DateFormatter.formatStringToDate(dateText: $0, format: "yyyyMMdd") == nil {
                    alertData.accept((ErrorType.incorrectDecoding.title, ErrorType.incorrectDecoding.message))
                    return false
                }
                return true
            }
            .flatMap {
                let param = MovieParameter(key: APIKey.movieKey, targetDt: $0)
                let router = NetworkRouter.trendMovie(param: param)
                return NetworkManager.callRequestWithResultType(router: router, type: MovieRank.self)
            }
            .bind { response in
                switch response {
                case .success(let data):
                    movieData.accept(data.boxOfficeResult.movieData)
                case .failure(let error):
                    
                    var errorType = ErrorType.unknown
                    
                    if let afError = error.asAFError,
                       let urlError = afError.underlyingError as? URLError {
                        switch urlError.code {
                        case .notConnectedToInternet:
                            errorType = .notConnectedToInternet
                        case .cannotFindHost, .cannotConnectToHost:
                            errorType = .serverError
                        default:
                            errorType = .incorrectDecoding
                        }
                    } else {
                        errorType = .unknown
                    }
                    
                    alertData.accept((errorType.title, errorType.message))
                }
            }
            .disposed(by: disposeBag)
        
        return Output(movieData: movieData, alertData: alertData)
    }
}
