//
//  BaseViewController.swift
//  SeSACDay8HW
//
//  Created by 정성희 on 8/23/25.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureView() {
        view.backgroundColor = .second
        
        navigationItem.backButtonTitle = ""
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = .second
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.primary]
        
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
    }
    
    func configureHierarchy() { }
    func configureLayout() { }
}
