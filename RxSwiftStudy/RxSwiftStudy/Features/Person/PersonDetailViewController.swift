//
//  PersonDetailViewController.swift
//  RxSwiftStudy
//
//  Created by 정성희 on 8/20/25.
//

import UIKit
import SnapKit

class PersonDetailViewController: UIViewController {

    var name = ""
    let nameLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        nameLabel.text = name
        
        configure()
    }
    
    private func configure() {
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
