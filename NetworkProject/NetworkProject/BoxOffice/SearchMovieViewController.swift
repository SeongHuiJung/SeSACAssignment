//
//  SearchMovieViewController.swift
//  NetworkProject
//
//  Created by 정성희 on 7/23/25.
//

import UIKit
import SnapKit

class SearchMovieViewController: UIViewController {

    let searchTextField = UITextField()
    let searchTextFieldLine = UIView()
    let searchButton = UIButton()
    let tableView = UITableView()
    
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
        // TODO: 랜덤값 중복되지 않도록 로직 설정
        var result = [Movie]()
        for _ in 0..<10 {
            guard let data = MovieInfo.movies.randomElement() else { return [] }
            result.append(data)
        }
        return result
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
        tableView.rowHeight = 44
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchMovieTableViewCell.self, forCellReuseIdentifier: SearchMovieTableViewCell.identifier)
        
        searchTextField.delegate = self
        searchTextField.backgroundColor = .clear
        searchTextField.textColor = .white
        searchTextField.font = UIFont.systemFont(ofSize: 12)
        
        searchTextFieldLine.backgroundColor = .white
        searchTextFieldLine.tintColor = .white
        
        searchButton.backgroundColor = .white
        searchButton.setTitle("검색", for: .normal)
        searchButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        searchButton.setTitleColor(.black, for: .normal)
    }
}
