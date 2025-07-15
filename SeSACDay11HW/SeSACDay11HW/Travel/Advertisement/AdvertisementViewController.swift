//
//  AdvertisementViewController.swift
//  SeSACDay11HW
//
//  Created by 정성희 on 7/15/25.
//

import UIKit

class AdvertisementViewController: UIViewController {

    static let identifier = "AdvertisementViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationUI()
    }
}

// Action
extension AdvertisementViewController {
    @objc func backbuttonTapped() {
        dismiss(animated: true)
    }
}

// Navgation
extension AdvertisementViewController {
    func setNavigationUI() {
        navigationItem.title = "광고 화면"
        navigationController?.navigationBar.tintColor = .black
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .done, target: self, action: #selector(backbuttonTapped))
    }
}
