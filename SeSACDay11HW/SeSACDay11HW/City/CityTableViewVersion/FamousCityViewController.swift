//
//  FamousCityViewController.swift
//  SeSACDay11HW
//
//  Created by 정성희 on 7/16/25.
//

import UIKit

class FamousCityViewController: UIViewController {
    @IBOutlet var textField: UITextField!
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var citySegment: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    
    let cityList = CityInfo()
    
    var segmentSelected = 0 {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connectXib()
        setUI()
    }
}

// MARK: - Xib
extension FamousCityViewController {
    func connectXib() {
        let xib = UINib(nibName: TravelCityTableViewCell.identifier, bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: TravelCityTableViewCell.identifier)
    }
}

// MARK: - TableView
extension FamousCityViewController: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // searchBar 이용해서 검색하는 코드
        //guard let text = searchBar.text else { return 0 }
        
        // textField 이용해서 검색하는 코드
        guard let text = textField.text else { return 0 }
        
        if text.contains(" ") {
            return 0
        }
        else if text.isEmpty == true{
            switch segmentSelected {
            case 0: return cityList.city.count
            case 1: return cityList.city.filter{$0.domesticTravel == true}.count
            case 2: return cityList.city.filter{$0.domesticTravel == false}.count
            default: return cityList.city.count
            }
        }
        else {
            let cityList = getSearchResultList(text: text)
            switch segmentSelected {
            case 0: return cityList.count
            case 1: return cityList.filter{$0.domesticTravel == true}.count
            case 2: return cityList.filter{$0.domesticTravel == false}.count
            default: return cityList.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        // searchBar 이용해서 검색하는 코드
        //guard let text = searchBar.text else { return UITableViewCell() }
        
        // textField 이용해서 검색하는 코드
        guard let text = textField.text else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TravelCityTableViewCell.identifier, for: indexPath) as! TravelCityTableViewCell
        
        if text.isEmpty == true {
            switch segmentSelected {
            case 0: cell.configureUI(row: cityList.city[indexPath.row])
            case 1: cell.configureUI(row: cityList.city.filter{$0.domesticTravel == true}[indexPath.row])
            case 2: cell.configureUI(row: cityList.city.filter{$0.domesticTravel == false}[indexPath.row])
            default: cell.configureUI(row: cityList.city[indexPath.row])
            }
        }
        else {
            let cityList = getSearchResultList(text: text)
            switch segmentSelected {
            case 0: cell.configureUI(row: cityList[indexPath.row])
            case 1: cell.configureUI(row: cityList.filter{$0.domesticTravel == true}[indexPath.row])
            case 2: cell.configureUI(row: cityList.filter{$0.domesticTravel == false}[indexPath.row])
            default: cell.configureUI(row: cityList[indexPath.row])
            }
            
            cell.changeKeywordColor(label: cell.cityNameLabel, keyword: text)
            cell.changeKeywordColor(label: cell.cityExplainLabel, keyword: text)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "CityDetailViewController") as! CityDetailViewController
        
        viewController.cityData = cityList.city[indexPath.row]
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - segmentSelected controll
extension FamousCityViewController {
    @IBAction func citySegmentChanged(_ sender: UISegmentedControl) {
        segmentSelected = citySegment.selectedSegmentIndex
    }
}

// MARK: - TextField Action
extension FamousCityViewController {
    
    @IBAction func textFieldChanged(_ sender: UITextField) {
        tableView.reloadData()
    }
    
    @IBAction func textFieldDidEndOnExit(_ sender: UITextField) {
        tableView.reloadData()
    }
    
    func getSearchResultList(text: String) -> [City] {
        let text = text.lowercased()
        var result: [City] = []
        
        for city in cityList.city {
            if  city.cityName.lowercased().contains(text) ||
                city.cityEnglishName.lowercased().contains(text) ||
                city.cityExplain.lowercased().contains(text) {
                result.append(city)
            }
        }
        
        return result
    }
}

// MARK: - UI
extension FamousCityViewController {
    func setUI() {
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        textField.delegate = self
        searchBar.delegate = self
        
        searchBar.autocapitalizationType = .none
    }
}

// MARK: - TextField Delegate
extension FamousCityViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 입력중인 상태는 textField.text 에 나오지 않음
        // 그래서 한글자씩 늦게 반영이 되어 검색이 제대로 되지 않는 상황
        print(#function, textField.text!)
        return true
    }
}

// MARK: - SearchBar Delegate
extension FamousCityViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        tableView.reloadData()
        print(#function, searchText)
    }
}
