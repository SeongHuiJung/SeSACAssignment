//
//  SearchViewController.swift
//  Shopping
//
//  Created by 정성희 on 7/25/25.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
    let viewModel = SearchViewModel()
    
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
        setBind()
    }
    
    func setBind() {
        viewModel.outputShowAlert.lazyBind { message in
            let alert = AlertSingleton.shared.getAlert(title: "", message: message)
            self.present(alert, animated: true)
        }
        
        viewModel.outputPushNextVC.lazyBind { searchText in
            let viewController = ProductListViewController()
            viewController.viewModel.output.searchText.value = searchText
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        
        viewModel.outputSearchBarCancelButtonTapped.lazyBind {
            self.searchBar.text = ""
        }
    }
}

// MARK: - SearchBar Delegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.inputSearchBarButtonTapped.value = searchBar.text
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.inputSearchBarCancelButtonTapped.value = ()
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
