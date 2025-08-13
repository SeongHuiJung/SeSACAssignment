//
//  ProductListViewModel.swift
//  Shopping
//
//  Created by 정성희 on 8/12/25.
//

import Foundation
import Alamofire

class ProductListViewModel {
    
    struct Input {
        var loadProductImage = Observable("")
        var loadRecommendProductImage = Observable("")
        var pagenationTrigger: Observable<(Int, String)> = Observable((0, ""))
        var tagSelect = Observable(0)
    }
    
    struct Output {
        var productList: Observable<[ShopItem]> = Observable([])
        var searchText = Observable("")
        var productCollectionViewReload = Observable(())
        var productCollectionViewScrollTop = Observable(())
        var productTotalCount = Observable("")
        var isHintLabelHidden = Observable(true)
        var showAlert: Observable<ErrorType> = Observable(CommonErrorType.unknownError)
        var sortType: Observable<SortType> = Observable(SortType.sim)
        
        var recommendProductList: Observable<[ShopItem]> = Observable([])
        var recommendCollectionViewReload = Observable(())
    }
    
    var input: Input
    var output: Output
    
    private var page = 1 // 현재 페이지
    private var endPage = 0 // 최대 페이지
    private var start = 1
    private var display = 20
    
    init() {
        input = Input()
        output = Output()
        
        input.loadProductImage.lazyBind { searchText in
            self.updateProductImage(searchText: searchText)
        }
        
        input.loadRecommendProductImage.lazyBind { searchText in
            self.updateRecommendProductImage(searchText: searchText)
        }
        
        input.pagenationTrigger.lazyBind { (row, searchText) in
            if row == self.output.productList.value.count - 3 && self.page != self.endPage {
                self.page += 1
                self.start = self.page * self.display
                self.updateProductImage(searchText: searchText)
            }
        }
        
        input.tagSelect.lazyBind { row in
            switch row {
            case 0: self.output.sortType.value = SortType.sim
            case 1: self.output.sortType.value = SortType.date
            case 2: self.output.sortType.value = SortType.dsc
            case 3: self.output.sortType.value = SortType.asc
            default: self.output.sortType.value = SortType.sim
            }
        }
        
        output.sortType.lazyBind { _ in
            self.resetData()
            self.updateProductImage(searchText: self.output.searchText.value)
        }
    }
}

// MARK: - Logic
extension ProductListViewModel {
    func updateProductImage(searchText: String) {
        callRequest(searchText: searchText, sort: output.sortType.value) { value in
            self.output.productList.value.append(contentsOf: value.items)

            self.output.productCollectionViewReload.value = ()
            
            if self.page == 1 && !self.output.productList.value.isEmpty {
                self.output.isHintLabelHidden.value = true
                self.output.productCollectionViewScrollTop.value = ()
                
                self.setEndPage(value: value)
                let totalProductNum = NumberFomatterSingleton.shared.foarmatter.string(from: value.total as NSNumber) ?? "0"
                
                self.output.productTotalCount.value = "\(totalProductNum) 개의 검색 결과"
            }
            
            // 검색결과가 없는 경우 빈 리스트임을 알리는 UI 표현
            if self.output.productList.value.isEmpty {
                self.output.isHintLabelHidden.value = false
            }
        }
    }
    
    func updateRecommendProductImage(searchText: String) {
        callRequest(searchText: searchText, sort: output.sortType.value) { value in
            self.output.recommendProductList.value.append(contentsOf: value.items)
            self.output.recommendCollectionViewReload.value = ()
        }
    }
    
    func callRequest(searchText: String, sort: SortType = SortType.sim, comopletionHandler: @escaping (Shop)->()) {

        let params = ShopParameter(query: searchText, display: String(display), sort: sort.englishName, start: String(start))
        
        NetworkManager.shared.callRequest(api: .searchProduct(params: params), decodeType: Shop.self) { value in
            comopletionHandler(value)
        } fail: { errorType in
            self.output.showAlert.value = errorType
        }
    }
    
    func resetData() {
        page = 1
        start = 1
        output.productList.value = []
    }
    
    func setEndPage(value: Shop) {
        var quotient = value.total / display
        let remainder = value.total % display
        if remainder != 0 { quotient += 1 }
        endPage = quotient
    }
}
