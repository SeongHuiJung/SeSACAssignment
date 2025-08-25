//
//  RequestLottoViewController.swift
//  TamagotchiGame
//
//  Created by 정성희 on 8/25/25.
//

import UIKit
import RxSwift
import RxCocoa

final class RequestLottoViewController: BaseViewController {

    private let tableView = UITableView()
    private let searchBar = UISearchBar()
    
    private let viewModel = RequestLottoViewModel()
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
       
        navigationItem.title = "회차별 로또 당첨 번호 확인"
    }
}

// MARK: - Bind
extension RequestLottoViewController {
    func bind() {
        let searchBarTapObservable = searchBar.rx.searchButtonClicked.withLatestFrom(searchBar.rx.text.orEmpty)
        let input = RequestLottoViewModel.Input(textFieldReturnTapped: searchBarTapObservable)
        let output = viewModel.transform(input: input)
        
        output.lottoList
        // 받은 데이터를 바로 bind
            .bind(to: tableView.rx.items(cellIdentifier: ListBaseTableViewCell.identifier, cellType: ListBaseTableViewCell.self)) { (row, value, cell) in
                cell.titleLabel.text = String(value)
            }
            .disposed(by: disposeBag)
    }
}
