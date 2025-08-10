//
//  BaseViewController.swift
//  MVVMBasic
//
//  Created by 정성희 on 8/10/25.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureConstraint()
        configureView()
    }
    
    func configureHierarchy() {}
    func configureConstraint() {}
    func configureView() {}
}
