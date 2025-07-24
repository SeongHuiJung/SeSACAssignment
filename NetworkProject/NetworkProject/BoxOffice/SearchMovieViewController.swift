//
//  SearchMovieViewController.swift
//  NetworkProject
//
//  Created by 정성희 on 7/23/25.
//

import UIKit
import SnapKit
import Alamofire

class SearchMovieViewController: UIViewController {
    
    var searchDateString = ""
    private let movieKey = Bundle.main.infoDictionary?["MovieKey"] as! String
    
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
        addTarget()
        
        searchDateString = getYesterDayString()
        callRequestMovieRank()
    }
}

// MARK: - Logic
extension SearchMovieViewController {
    
    @objc func updateSearchDateString() {
        guard let text = searchTextField.text else { return }
        searchDateString = text
    }

    @objc func callRequestMovieRank() {
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=" + movieKey + "&targetDt=" + searchDateString + "#"
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: MovieRank.self) { response in
                switch response.result {
                case .success(let value):
                    
                    // 데이터 nil 검사
                    guard self.isValidMovieData(movieData: value) else { return }
                    
                    // 데이터 업데이트
                    self.rankList = self.getUpdateRankListData(movieData: value)
                    
                    // 테이블뷰 fetch
                    self.tableView.reloadData()
                    
                case .failure(let error):
                    print("fail", error)
                }
            }
    }
    
    func isValidMovieData(movieData: MovieRank) -> Bool {
        let list = movieData.boxOfficeResult.movieData

        for i in 0..<list.count {
            if list[i].name == nil { print("올바른 데이터를 받지 못했습니다"); return false }
            if list[i].openDate == nil { print("올바른 데이터를 받지 못했습니다"); return false }
            if list[i].rank == nil { print("올바른 데이터를 받지 못했습니다"); return false }
        }

        return true
    }
    
    func getUpdateRankListData(movieData: MovieRank) -> [Movie] {
        let list = movieData.boxOfficeResult.movieData
        var newMovieList = [Movie]()
        for item in list {
            newMovieList.append(Movie(title: item.name!, releaseDate: item.openDate!, rank: Int(item.rank!)!))
        }
        
        return newMovieList
    }
    
    func getYesterDayString() -> String {
        let date = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        return DateFormatter.formatDateToString(date: date, format: "yyyyMMdd")
    }
}

// MARK: - AddTarget
extension SearchMovieViewController {
    func addTarget() {
        searchButton.addTarget(self, action: #selector(updateSearchDateString), for: .touchUpInside)
        searchButton.addTarget(self, action: #selector(callRequestMovieRank), for: .touchUpInside)
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
        updateSearchDateString()
        callRequestMovieRank()
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
