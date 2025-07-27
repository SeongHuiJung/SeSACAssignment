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
    
    private let NaverClientId = Bundle.main.infoDictionary?["NaverClientId"] as! String
    private let NaverClientSecret = Bundle.main.infoDictionary?["NaverClientSecret"] as! String
    
    
    private var totalProductLabel = CustomUILabel(text: "", textColor: .systemGreen, alignment: .left, size: 12)
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionView.getLayoutVertical(cellCount: 2, gap: 10))
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        callRequest()
    }
}

extension ProductListViewController {
    func callRequest() {
        // 구조화
        let display = 100
        let query = "query=\(searchText)&display=\(display)"
        let url = URLType.ShopUrl.rawValue + query
        
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
                    self.totalProductLabel.text = "\(String(value.total)) 개의 검색 결과"
                    self.collectionView.reloadData()
                case .failure(let error):
                    print("fail", error)
                }
            }
    }
}

extension ProductListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        produtList.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductListCollectionViewCell.identifier, for: indexPath) as! ProductListCollectionViewCell
        cell.configureData(data: produtList.items[indexPath.item])
        return cell
    }
}

extension ProductListViewController: ViewDesignProtocol {
    func configureHierarchy() {
        [totalProductLabel, collectionView].forEach { view.addSubview($0) }
    }
    
    func configureLayout() {
        totalProductLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(4)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(totalProductLabel.snp.bottom).offset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        view.backgroundColor = .black
        navigationItem.title = searchText
        
        collectionView.register(ProductListCollectionViewCell.self, forCellWithReuseIdentifier: ProductListCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
    }
}
