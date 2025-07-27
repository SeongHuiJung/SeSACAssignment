//
//  ProductListViewController.swift
//  Shopping
//
//  Created by 정성희 on 7/27/25.
//

import UIKit
import Alamofire

class ProductListViewController: UIViewController {

    var searchText = ""
    var produtList = Shop(items: [], total: 0)
    let sortTypeList = ["정확도", "날짜순", "가격높은순", "가격낮은순"]
    
    private let NaverClientId = Bundle.main.infoDictionary?["NaverClientId"] as! String
    private let NaverClientSecret = Bundle.main.infoDictionary?["NaverClientSecret"] as! String
    private var totalProductLabel = CustomUILabel(text: "", textColor: .systemGreen, alignment: .left, size: 12)
    
    lazy private var productCollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionView.getLayoutVertical(cellCount: 2, gap: 10))
        collectionView.register(ProductListCollectionViewCell.self, forCellWithReuseIdentifier: ProductListCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    lazy private var tagCollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionView.getLayoutHorizontal(cellCount: 2, gap: 10))
        collectionView.register(SortTagCollectionViewCell.self, forCellWithReuseIdentifier: SortTagCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        callRequest()
    }
}

// MARK: - Network
extension ProductListViewController {
    func callRequest(sort: SortType = SortType.sim) {

        let display = 100

        let params = [
            "query" : searchText,
            "display" : String(display),
            "sort" : sort.rawValue
        ]
        
        let url = URLType.naverShop(params: params).url
        
        let header: HTTPHeaders = [
            "X-Naver-Client-Id" : NaverClientId,
            "X-Naver-Client-Secret" : NaverClientSecret
        ]
        
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Shop.self) { response in
                switch response.result {
                case .success(let value):
                    self.produtList = value
                    let totalProductNum = NumberFomatterSingleton.shared.foarmatter.string(from: value.total as NSNumber) ?? "0"
                    self.totalProductLabel.text = "\(totalProductNum) 개의 검색 결과"
                    self.productCollectionView.reloadData()
                case .failure(let error):
                    print("fail", error)
                }
            }
    }
}

// MARK: - CollectionView Delegate
extension ProductListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == productCollectionView {
            produtList.items.count
        }
        else {
            sortTypeList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == productCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductListCollectionViewCell.identifier, for: indexPath) as! ProductListCollectionViewCell
            cell.configureData(data: produtList.items[indexPath.item])
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SortTagCollectionViewCell.identifier, for: indexPath) as! SortTagCollectionViewCell
            cell.configureData(text: sortTypeList[indexPath.item])
            if indexPath.row == 0 {
                cell.isSelectedTag = true
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == tagCollectionView {
            
            if let cell = collectionView.cellForItem(at: indexPath) as? SortTagCollectionViewCell {
                cell.isSelectedTag = true
                
                for i in 0..<sortTypeList.count {
                    if i != indexPath.row {
                        if let cell = collectionView.cellForItem(at: IndexPath(row: i, section: 0)) as? SortTagCollectionViewCell {
                            cell.isSelectedTag = false
                        }
                    }
                }
            }
            
            var sortType = ""
            
            switch indexPath.row {
            case 0: sortType = SortType.sim.rawValue
            case 1: sortType = SortType.date.rawValue
            case 2: sortType = SortType.dsc.rawValue
            case 3: sortType = SortType.asc.rawValue
            default: sortType = SortType.sim.rawValue
            }
            callRequest(sort: SortType(rawValue: sortType) ?? SortType.sim)
        }
    }
}

// MARK: UI Delegate
extension ProductListViewController: ViewDesignProtocol {
    func configureHierarchy() {
        [totalProductLabel, tagCollectionView, productCollectionView].forEach { view.addSubview($0) }
    }
    
    func configureLayout() {
        totalProductLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(4)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        tagCollectionView.snp.makeConstraints { make in
            make.top.equalTo(totalProductLabel.snp.bottom).offset(10)
            make.height.equalTo(32)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        productCollectionView.snp.makeConstraints { make in
            make.top.equalTo(tagCollectionView.snp.bottom).offset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        view.backgroundColor = .black
        navigationItem.title = searchText
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}
