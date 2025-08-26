//
//  SearchMovieRankViewModel.swift
//  TamagotchiGame
//
//  Created by 정성희 on 8/26/25.
//

import Foundation
import RxSwift
import RxCocoa
// https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f856f2c3efc33d98f90758270686fab9&targetDt=20250825
final class SearchMovieRankViewModel {
    struct Input {
        let textFieldReturnTapped: Observable<ControlProperty<String>.Element>
    }
    
    struct Output {
        let movieData: PublishRelay<[BoxOffice]>
    }
    
    init() {}
    
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        
        let movieData: PublishRelay<[BoxOffice]> = PublishRelay()
        
        input.textFieldReturnTapped
            .distinctUntilChanged() // 0826 reveiw: indicator
            .flatMap {
                let param = MovieParameter(key: APIKey.movieKey, targetDt: $0)
                let router = NetworkRouter.trendMovie(param: param)
                return NetworkManager.callRequest(router: router, type: MovieRank.self)
            }
            .subscribe(with: self) { owner, movieRankData in
                print("데이터",  movieRankData)
                movieData.accept(movieRankData.boxOfficeResult.movieData)
            } onError: { owner, error in
                print(error)
            } onCompleted: { owner in
                print("onCompleted")
            } onDisposed: { owner in
                print("onDisposed")
            }
            .disposed(by: disposeBag)
        
        return Output(movieData: movieData)
    }
}
