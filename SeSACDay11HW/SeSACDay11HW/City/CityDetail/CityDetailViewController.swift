//
//  CityDetailViewController.swift
//  SeSACDay11HW
//
//  Created by 정성희 on 7/16/25.
//

import UIKit

class CityDetailViewController: UIViewController {

    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var cityEnglishNameLabel: UILabel!
    @IBOutlet var cityExplainLabel: UILabel!
    
    static let identifier = "CityDetailViewController"
    
    var cityData: City = City(cityName: "", cityEnglishName: "", cityExplain: "", cityImage: "", domesticTravel: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
}

extension CityDetailViewController {
    func setUI() {
        cityNameLabel.text = cityData.cityName
        cityEnglishNameLabel.text = cityData.cityEnglishName
        cityExplainLabel.text = cityData.cityExplain
    }
}
