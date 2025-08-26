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
            
            .flatMap {
                let param = MovieParameter(key: APIKey.movieKey, targetDt: $0)
                let router = NetworkRouter.trendMovie(param: param)
                return NetworkManager.callRequest(router: router, type: MovieRank.self)
            }
            .bind(with: self) { owner, response in
                switch response {
                case .success(let data):
                    movieData.accept(data.boxOfficeResult.movieData)
                case .failure(let error):
                    alertData.accept(("통신 에러", "에러가 발생했어요. 다시 시도해주세요."))
                }
            }
            .disposed(by: disposeBag)
        
        return Output(movieData: movieData, alertData: alertData)
    }
}
