//
//  SearchViewController.swift
//  Shopping
//
//  Created by 정성희 on 7/25/25.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
    let searchBar = {
        let searchBar = UISearchBar()
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = .darkGray
            textField.attributedPlaceholder =  NSAttributedString(string: textField.placeholder ?? "브랜드, 상품, 프로필, 태그 등", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
            textField.textColor = .lightGray
            
            if let leftView = textField.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = UIColor.lightGray
            }
        }
        // 투명한 이미지를 넣어 투명하게 보이도록 설정
        searchBar.backgroundImage = UIImage()

        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
}

// MARK: - Logic
extension SearchViewController {
    private func isHaveOnlyWhiteSpace() -> Bool {
        guard let text = searchBar.text else { return true }
        for char in text {
            if char != " " {
                return false
            }
        }
        return true
    }
}

// MARK: - SearchBar Delegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        
        guard !isHaveOnlyWhiteSpace() else {
            let alert = AlertSingleton.shared.getAlert(title: "", message: "검색어를 입력해 주세요")
            present(alert, animated: true)
            return
        }
        
        guard text.count >= 2 else {
            let alert = AlertSingleton.shared.getAlert(title: "", message: "2글자 이상 입력해 주세요")
            present(alert, animated: true)
            return
        }
        
        let viewController = ProductListViewController()
        viewController.searchText = text
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
}

// MARK: UI Delegate
extension SearchViewController: ViewDesignProtocol {
    func configureHierarchy() {
        [searchBar].forEach { view.addSubview($0) }
    }
    
    func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
    }
    
    func configureView() {
        view.backgroundColor = .black
        setNavigation()
        setDelegate()
    }
    
    func setNavigation() {
        navigationItem.title = "영캠러의 쇼핑쇼핑"
        navigationItem.titleView?.tintColor = .white
        navigationController?.navigationBar.tintColor = .white
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    func setDelegate() {
        searchBar.delegate = self
    }
}
