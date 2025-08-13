//
//  ProductListViewController.swift
//  Shopping
//
//  Created by 정성희 on 7/27/25.
//

import UIKit

class ProductListViewController: UIViewController {

    let viewModel = ProductListViewModel()

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
    let emptyLabel = CustomUILabel(text: "텅", textColor: .white, alignment: .center, size: 50, weight: .heavy)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        setBind()
        
        loadProducts()
    }
    
    func setBind() {
        viewModel.output.searchText.bind { text in
            self.navigationItem.title = text
        }
        
        viewModel.output.productCollectionViewReload.lazyBind {
            self.productCollectionView.reloadData()
        }
        
        viewModel.output.productCollectionViewScrollTop.lazyBind {
            self.productCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
        
        viewModel.output.productTotalCount.lazyBind { text in
            self.totalProductLabel.text = text
        }
        
        viewModel.output.isHintLabelHidden.bind { isHidden in
            self.emptyLabel.isHidden = isHidden
        }
        
        viewModel.output.showAlert.lazyBind { errorType in
            self.showErrorAlert(errorType: errorType)
        }
        
        viewModel.output.recommendCollectionViewReload.lazyBind {
            self.recommendProductCollectionView.reloadData()
        }
    }
}

// MARK: - Network
extension ProductListViewController {
    
    func loadProducts() {
        viewModel.input.loadProductImage.value = viewModel.output.searchText.value
        viewModel.input.loadRecommendProductImage.value = viewModel.output.searchText.value
    }
}

// MARK: - CollectionView Delegate
extension ProductListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == productCollectionView {
            viewModel.output.productList.value.count
        }
        else if collectionView == tagCollectionView {
            SortType.allCases.count
        }
        else {
            viewModel.output.recommendProductList.value.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == productCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductListCollectionViewCell.identifier, for: indexPath) as! ProductListCollectionViewCell

            if !viewModel.output.productList.value.isEmpty {
                cell.configureData(data: viewModel.output.productList.value[indexPath.item], isLike: false)
            }
            
            return cell
        }
        else if collectionView == tagCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SortTagCollectionViewCell.identifier, for: indexPath) as! SortTagCollectionViewCell
            cell.configureData(text: SortType(rawValue: indexPath.item)?.koreanName ?? "정확도")
            if indexPath.row == 0 {
                cell.isSelectedTag = true
            }
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendProductCollectionViewCell.identifier, for: indexPath) as! RecommendProductCollectionViewCell

            cell.configureData(data: viewModel.output.recommendProductList.value[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == tagCollectionView && viewModel.output.sortType.value.rawValue != indexPath.row  {
            
            if let cell = collectionView.cellForItem(at: indexPath) as? SortTagCollectionViewCell {
                  cell.isSelectedTag = true
                
                for i in 0..<SortType.allCases.count {
                    if i != indexPath.row {
                        if let cell = collectionView.cellForItem(at: IndexPath(row: i, section: 0)) as? SortTagCollectionViewCell {
                              cell.isSelectedTag = false
                        }
                    }
                }
            }
            
            viewModel.input.tagSelect.value = indexPath.row
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard collectionView == productCollectionView else { return }
        viewModel.input.pagenationTrigger.value = (indexPath.row, viewModel.output.searchText.value)
    }
}

// MARK: UI Delegate
extension ProductListViewController: ViewDesignProtocol {
    func configureHierarchy() {
        [recommendProductCollectionView, totalProductLabel, tagCollectionView, productCollectionView, emptyLabel].forEach { view.addSubview($0) }
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
        
        emptyLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func configureView() {
        view.backgroundColor = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        emptyLabel.isHidden = true
    }
}
