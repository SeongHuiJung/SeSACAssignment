//
//  BaseViewController.swift
//  TamagotchiGame
//
//  Created by 정성희 on 8/25/25.
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
        view.backgroundColor = .white
        
        navigationItem.backButtonTitle = ""
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = .white
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
    }
    
    func configureHierarchy() { }
    func configureLayout() { }
    
}
