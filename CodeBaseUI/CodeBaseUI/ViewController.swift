//
//  ViewController.swift
//  CodeBaseUI
//
//  Created by 정성희 on 7/21/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func nextflixButtonTapped(_ sender: UIButton) {
        let vc = NetflixViewController()
        present(vc, animated: true)
    }
    
    @IBAction func naverPayButtonTapped(_ sender: UIButton) {
        let vc = NaverPayViewController()
        present(vc, animated: true)
    }
}

