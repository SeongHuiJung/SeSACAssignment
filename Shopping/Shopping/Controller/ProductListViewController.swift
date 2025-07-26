//
//  ProductListViewController.swift
//  Shopping
//
//  Created by 정성희 on 7/25/25.
//

import UIKit

class ProductListViewController: UIViewController {

    static let identifier = "ProductListViewController"
    
    var searchText = ""

//    var productList = []
    
    lazy private var tableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 44
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
    }
}

extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as! ProductTableViewCell
        return cell
    }
}

extension ProductListViewController: ViewDesignProtocol {
    func configureHierarchy() {
        [tableView].forEach { view.addSubview($0) }
    }
    
    func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    func configureView() {
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.identifier)
        navigationItem.title = searchText
    }
}
