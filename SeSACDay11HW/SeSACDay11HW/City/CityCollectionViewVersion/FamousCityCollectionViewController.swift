//
//  FamousViewController.swift
//  SeSACDay11HW
//
//  Created by 정성희 on 7/17/25.
//

import UIKit

class FamousCityCollectionViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var citySegment: UISegmentedControl! {
        didSet {
            
        }
    }
    
    var cityList = CityInfo().city
    
    var segmentSelected = 0 {
        didSet {
            updateCityList()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connectXib()
        setUI()
    }
}

// MARK: - Logic
extension FamousCityCollectionViewController {
    func updateCityList() {
        guard let text = textField.text else { return }
        cityList = getSegmentResultList()
        if !text.isEmpty {
            cityList = getSearchResultList(text: text)
        }
        
        collectionView.reloadData()
    }
    
    func getSegmentResultList() -> [City] {
        var filter: [City] = []
        let entireData = CityInfo().city
        switch segmentSelected {
        case 0: filter = entireData
        case 1: filter = entireData.filter{$0.domesticTravel}
        case 2: filter = entireData.filter{$0.domesticTravel == false}
        default: filter = entireData
        }
        return filter
    }
    
    func getSearchResultList(text: String) -> [City] {
        let text = text.lowercased()
        var filter: [City] = []
        
        for city in cityList {
            if  city.cityName.lowercased().contains(text) ||
                city.cityEnglishName.lowercased().contains(text) ||
                city.cityExplain.lowercased().contains(text) {
                filter.append(city)
            }
        }
        
        return filter
    }
}

// MARK: - Xib
extension FamousCityCollectionViewController {
    func connectXib() {
        let xib = UINib(nibName: FamousCollectionViewCell.identifier, bundle: nil)
        collectionView.register(xib, forCellWithReuseIdentifier: FamousCollectionViewCell.identifier)
    }
}

// MARK: - Collection View
extension FamousCityCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cityList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let text = textField.text else { return UICollectionViewCell() }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FamousCollectionViewCell.identifier, for: indexPath) as! FamousCollectionViewCell

        cell.configureUI(row: cityList[indexPath.row])
        
        if !text.isEmpty {
            cell.changeKeywordColor(label: cell.cityNameLabel, keyword: text)
            cell.changeKeywordColor(label: cell.cityExplainLabel, keyword: text)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: CityDetailViewController.identifier) as! CityDetailViewController
        
        viewController.cityData = cityList[indexPath.row]
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UI
extension FamousCityCollectionViewController {
    func setUI() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.collectionViewLayout = makeLayout()
    }
    
    func makeLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let deviceWidth = UIScreen.main.bounds.width
        
        let widthCellCount: CGFloat = 2
        let gap: CGFloat = 18
        
        let cellWidth: Double = deviceWidth - (gap * 2) - (gap * (widthCellCount - 1))
        layout.itemSize = CGSize(width: cellWidth / widthCellCount, height: 250)
        layout.sectionInset = UIEdgeInsets(top: gap, left: gap, bottom: gap, right: gap)
        layout.minimumLineSpacing = gap
        layout.minimumInteritemSpacing = gap
        layout.scrollDirection = .vertical
        return layout
    }
}

// MARK: - IBAction
extension FamousCityCollectionViewController {
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        segmentSelected = citySegment.selectedSegmentIndex
    }
    
    @IBAction func textFieldChanged(_ sender: UITextField) {
        updateCityList()
    }
}
