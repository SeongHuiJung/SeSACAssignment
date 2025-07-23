//
//  ViewController.swift
//  NetworkProject
//
//  Created by 정성희 on 7/23/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func lottoButtonTapped(_ sender: Any) {
        let viewController = LottoWinViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func boxOfficeButtonTapped(_ sender: UIButton) {
        let viewController = SearchMovieViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

