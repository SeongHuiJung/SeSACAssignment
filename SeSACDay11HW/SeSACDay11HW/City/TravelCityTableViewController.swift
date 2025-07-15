//
//  TavelCityTableViewController.swift
//  SeSACDay11HW
//
//  Created by 정성희 on 7/15/25.
//

import UIKit

class TravelCityTableViewController: UITableViewController {

    @IBOutlet var citySegment: UISegmentedControl!
    @IBOutlet var textField: UITextField!
    
    let cityList = CityInfo()
    
    var segmentSelected = 0 {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connectXib()
    }
}

// Xib
extension TravelCityTableViewController {
    func connectXib() {
        let xib = UINib(nibName: TravelCityTableViewCell.identifier, bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: TravelCityTableViewCell.identifier)
    }
}

// TableView
extension TravelCityTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if textField.text?.isEmpty == true {
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TravelCityTableViewCell.identifier, for: indexPath) as! TravelCityTableViewCell
        
        if textField.text?.isEmpty == true {
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
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
}

// segmentSelected controll
extension TravelCityTableViewController {
    @IBAction func citySegmentChanged(_ sender: UISegmentedControl) {
        segmentSelected = citySegment.selectedSegmentIndex
    }
}

// TextField Action
extension TravelCityTableViewController {
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
