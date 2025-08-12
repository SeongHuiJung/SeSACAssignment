//
//  ProductListViewModel.swift
//  Shopping
//
//  Created by 정성희 on 8/12/25.
//

import Foundation
import Alamofire

class ProductListViewModel {
    var inputLoadProductImage = Observable("")
    var inputLoadRecommendProductImage = Observable("")
    var inputPagenationTrigger: Observable<(Int, String)> = Observable((0, ""))
    
    var outputProductList: Observable<[ShopItem]> = Observable([])
    var outputSearchText = Observable("")
    var outputProductCollectionViewReload = Observable(())
    var outputProductCollectionViewScrollTop = Observable(())
    var outputProductTotalCount = Observable("")
    var outputIsHintLabelHidden = Observable(true)
    var outputShowAlert: Observable<ErrorType> = Observable(CommonErrorType.unknownError)
    
    var outputRecommendProductList: Observable<[ShopItem]> = Observable([])
    var outputRecommendCollectionViewReload = Observable(())
    
 
    private var sortType: SortType = SortType.sim
    private var page = 1 // 현재 페이지
    private var endPage = 0 // 최대 페이지
    private var start = 1
    private var display = 20
    
    init() {
        inputLoadProductImage.lazyBind { searchText in
            self.updateProductImage(searchText: searchText)
        }
        
        inputLoadRecommendProductImage.lazyBind { searchText in
            self.updateRecommendProductImage(searchText: searchText)
        }
        
        inputPagenationTrigger.lazyBind { (row, searchText) in
            if row == self.outputProductList.value.count - 3 && self.page != self.endPage {
                self.page += 1
                self.start = self.page * self.display
                self.updateProductImage(searchText: searchText)
            }
        }
    }
}

// MARK: - Logic
extension ProductListViewModel {
    func updateProductImage(searchText: String) {
        callRequest(searchText: searchText, sort: sortType) { value in
            self.outputProductList.value.append(contentsOf: value.items)

            self.outputProductCollectionViewReload.value = ()
            
            if self.page == 1 && !self.outputProductList.value.isEmpty {
                self.outputIsHintLabelHidden.value = true
                self.outputProductCollectionViewScrollTop.value = ()
                
                self.setEndPage(value: value)
                let totalProductNum = NumberFomatterSingleton.shared.foarmatter.string(from: value.total as NSNumber) ?? "0"
                
                self.outputProductTotalCount.value = "\(totalProductNum) 개의 검색 결과"
            }
            
            // 검색결과가 없는 경우 빈 리스트임을 알리는 UI 표현
            if self.outputProductList.value.isEmpty {
                self.outputIsHintLabelHidden.value = false
            }
        }
    }
    
    func updateRecommendProductImage(searchText: String) {
        callRequest(searchText: searchText, sort: sortType) { value in
            self.outputRecommendProductList.value.append(contentsOf: value.items)
            self.outputRecommendCollectionViewReload.value = ()
        }
    }
    
    func callRequest(searchText: String, sort: SortType = SortType.sim, comopletionHandler: @escaping (Shop)->()) {
        
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
            self.outputShowAlert.value = errorType
            
        }
    }
    
    func resetData() {
        page = 1
        start = 1
        outputProductList.value = []
    }
    
    func setEndPage(value: Shop) {
        var quotient = value.total / display
        let remainder = value.total % display
        if remainder != 0 { quotient += 1 }
        endPage = quotient
    }
}
