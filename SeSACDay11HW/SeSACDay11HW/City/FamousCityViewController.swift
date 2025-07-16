//
//  FamousCityViewController.swift
//  SeSACDay11HW
//
//  Created by 정성희 on 7/16/25.
//

import UIKit

class FamousCityViewController: UIViewController {
    @IBOutlet var textField: UITextField!
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
        guard let text = textField.text else { return 0 }
        
        if text.contains(" ") {
            return 0
        }
        else if textField.text?.isEmpty == true{
            switch segmentSelected {
            case 0: return cityList.city.count
            case 1: return cityList.city.filter{$0.domesticTravel == true}.count
            case 2: return cityList.city.filter{$0.domesticTravel == false}.count
            default: return cityList.city.count
            }
        }
        else {
            let cityList = getSearchResultList()
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
            let cityList = getSearchResultList()
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
    
    @IBAction func textFieldDidEndOnExit(_ sender: UITextField) {
        tableView.reloadData()
    }
    
    func getSearchResultList() -> [City]{
        guard let text = textField.text?.lowercased() else { return [] }
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
    }
}
