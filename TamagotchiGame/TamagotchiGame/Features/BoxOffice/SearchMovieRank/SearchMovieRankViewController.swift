//
//  SearchMovieRankViewController.swift
//  TamagotchiGame
//
//  Created by 정성희 on 8/25/25.
//

import UIKit
//import Alamofire
import RxSwift
import RxCocoa

final class SearchMovieRankViewController: BaseViewController {

    private let tableView = UITableView()
    private let searchBar = UISearchBar()
    
    private let viewModel = SearchMovieRankViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        view.addSubview(tableView)
        view.addSubview(searchBar)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override func configureView() {
        super.configureView()
        
        tableView.register(ListBaseTableViewCell.self, forCellReuseIdentifier: ListBaseTableViewCell.identifier)
        tableView.backgroundColor = .lightGray
        tableView.rowHeight = 80
        
        navigationItem.title = "날짜별 트랜드 영화 검색"
    }
}

// MARK: - Bind
extension SearchMovieRankViewController {
    func bind() {
        let searchBarTapObservable = searchBar.rx.searchButtonClicked.withLatestFrom(searchBar.rx.text.orEmpty)
        let input = SearchMovieRankViewModel.Input(textFieldReturnTapped: searchBarTapObservable)
        let output = viewModel.transform(input: input)
        
        output.movieData
            .bind(to: tableView.rx.items(cellIdentifier: ListBaseTableViewCell.identifier, cellType: ListBaseTableViewCell.self)) { (row, value, cell) in
                cell.titleLabel.text = value.name
            }
            .disposed(by: disposeBag)
    }
}
