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
    var produtList = [ShopItem]()
    //   var produtList = [(ShopItem, Bool)]()
    var recommendProductList = [ShopItem]()
    
    var page = 1 // 현재 페이지
    var endPage = 0 // 최대 페이지
    var start = 1
    var display = 20
    
    let sortTypeList = ["정확도", "날짜순", "가격높은순", "가격낮은순"]
    let sortTypeListEng = ["sim", "date", "dsc", "asc"]
    var sortType: SortType = SortType.sim
    
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
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionView.getLayoutHorizontal(cellCount: 1, gap: 10, itemSize: CGSize(width: 80, height: 32)))
        collectionView.register(SortTagCollectionViewCell.self, forCellWithReuseIdentifier: SortTagCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    lazy private var recommendProductCollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionView.getLayoutHorizontal(cellCount: 1, gap: 10, itemSize: CGSize(width: 100, height: 100)))
        collectionView.register(RecommendProductCollectionViewCell.self, forCellWithReuseIdentifier: RecommendProductCollectionViewCell.identifier)
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
        
        updateProductImage()
        updateRecommendProductImage()
    }
}

// MARK: - Network
extension ProductListViewController {
    
    func updateProductImage() {
        callRequest(sort: sortType) { value in
            self.produtList.append(contentsOf: value.items)
            self.productCollectionView.reloadData()
            
            if self.page == 1 {
                self.productCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                self.setEndPage(value: value)
                let totalProductNum = NumberFomatterSingleton.shared.foarmatter.string(from: value.total as NSNumber) ?? "0"
                self.totalProductLabel.text = "\(totalProductNum) 개의 검색 결과"
            }
        }
    }
    
    func updateRecommendProductImage() {
        callRequest(sort: sortType) { value in
            self.recommendProductList.append(contentsOf: value.items)
            self.recommendProductCollectionView.reloadData()
        }
    }
    
    func callRequest(sort: SortType = SortType.sim, comopletionHandler: @escaping (Shop)->()) {
        
        let params = [
            "query" : searchText,
            "display" : String(display),
            "sort" : sort.rawValue,
            "start" : String(start)
        ]
        
        let url = URLType.naverShop(params: params).url
        let header: HTTPHeaders = [
            "X-Naver-Client-Id" : APIKey.naverClientId,
            "X-Naver-Client-Secret" : APIKey.naverClientSecret
        ]
        
        NetworkManager.shared.callRequest(url: url, header: header, sort: sort) { value in
            comopletionHandler(value)
            
        } fail: { errorType in
            
            // VC 에서 분리처리하지 말고 errorType 자체를 shorAlert 함수로 넘겨주자
            // shorAlert 에서 errorType 분리처리를 해주면 좋을 것
            // 이렇게 해야 다른 네트워킹 에러처리에서도 errorType 을 매번 분기처리 하지 않으면서 shorAlert 를 재활용할 수 있을 것
            self.showErrorAlert(errorType: errorType)
        }
    }
    
    func resetData() {
        page = 1
        start = 1
        produtList = []
    }
    
    func setEndPage(value: Shop) {
        var quotient = value.total / display
        let remainder = value.total % display
        if remainder != 0 { quotient += 1 }
        endPage = quotient
    }
}

// MARK: - CollectionView Delegate
extension ProductListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == productCollectionView {
            produtList.count
        }
        else if collectionView == tagCollectionView {
            sortTypeList.count
        }
        else {
            recommendProductList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == productCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductListCollectionViewCell.identifier, for: indexPath) as! ProductListCollectionViewCell

            
            print(indexPath.item, "번째 cell 로드")

            if !produtList.isEmpty {
                cell.configureData(data: produtList[indexPath.item], isLike: false)
            }
            
            return cell
        }
        else if collectionView == tagCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SortTagCollectionViewCell.identifier, for: indexPath) as! SortTagCollectionViewCell
            cell.configureData(text: sortTypeList[indexPath.item])
            if indexPath.row == 0 {
                cell.isSelectedTag = true
            }
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendProductCollectionViewCell.identifier, for: indexPath) as! RecommendProductCollectionViewCell

            cell.configureData(data: recommendProductList[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == tagCollectionView && sortType.rawValue != sortTypeListEng[indexPath.row] {
            
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
            
            switch indexPath.row {
            case 0: sortType = SortType.sim
            case 1: sortType = SortType.date
            case 2: sortType = SortType.dsc
            case 3: sortType = SortType.asc
            default: sortType = SortType.sim
            }
            resetData()
            updateProductImage()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard collectionView == productCollectionView else { return }
        if indexPath.row == produtList.count - 3 && page != endPage {
            page += 1
            start = page * display
            updateProductImage()
        }
    }
}

// MARK: UI Delegate
extension ProductListViewController: ViewDesignProtocol {
    func configureHierarchy() {
        [recommendProductCollectionView, totalProductLabel, tagCollectionView, productCollectionView].forEach { view.addSubview($0) }
    }
    
    func configureLayout() {
        recommendProductCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(4)
            make.height.equalTo(100)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        totalProductLabel.snp.makeConstraints { make in
            make.top.equalTo(recommendProductCollectionView.snp.bottom).offset(4)
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
