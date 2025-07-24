//
//  SearchMovieViewController.swift
//  NetworkProject
//
//  Created by 정성희 on 7/23/25.
//

import UIKit
import SnapKit

class SearchMovieViewController: UIViewController {

    let searchTextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.textColor = .white
        textField.font = UIFont.systemFont(ofSize: 12)
        return textField
    }()
    let searchTextFieldLine = {
        let view = UIView()
        view.backgroundColor = .white
        view.tintColor = .white
        return view
    }()
    let searchButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("검색", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    let tableView = {
        let tableView = UITableView()
        tableView.rowHeight = 44
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    var rankList = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        fetchData()
        addTarget()
    }
}

// MARK: - Logic
extension SearchMovieViewController {
    func fetchData() {
        rankList = getRandomData()
        tableView.reloadData()
    }
    
    func getRandomData() -> [Movie] {
        return Array(MovieInfo.movies.shuffled()[0...9])
    }
    
    @objc func searchButtonTapped() {
        fetchData()
    }
}

// MARK: - AddTarget
extension SearchMovieViewController {
    func addTarget() {
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
}

// MARK: - TableView Delegate
extension SearchMovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rankList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchMovieTableViewCell.identifier, for: indexPath) as! SearchMovieTableViewCell
        
        cell.configure(index: String(indexPath.row + 1), item: rankList[indexPath.row])
        
        return cell
    }
}

// MARK: - TextField Delegate
extension SearchMovieViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        fetchData()
        return true
    }
}

// MARK: - UI Protocol
extension SearchMovieViewController: ViewDesignProtocol {
    func configureHierarchy() {
        [searchTextField, searchTextFieldLine, searchButton, tableView].forEach { view.addSubview($0) }
    }
    
    func configureLayout() {
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(44)
        }
        
        searchTextFieldLine.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom)
            make.horizontalEdges.equalTo(searchTextField)
            make.height.equalTo(4)
        }
        
        searchButton.snp.makeConstraints { make in
            make.verticalEdges.equalTo(searchTextField)
            make.left.equalTo(searchTextField.snp.right).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.width.equalTo(60)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(350)
        }
    }
    
    func configureView() {
        view.backgroundColor = .black

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchMovieTableViewCell.self, forCellReuseIdentifier: SearchMovieTableViewCell.identifier)
        searchTextField.delegate = self
    }
}
