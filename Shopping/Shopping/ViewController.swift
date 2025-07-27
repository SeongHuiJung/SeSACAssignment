//
//  ViewController.swift
//  Shopping
//
//  Created by 정성희 on 7/25/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
    }
    @IBAction func shoppingButtonTapped(_ sender: Any) {
        let viewController = SearchViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

