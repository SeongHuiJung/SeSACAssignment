//
//  ChangeTamagotchiViewController.swift
//  TamagotchiGame
//
//  Created by 정성희 on 8/24/25.
//

import UIKit
import RxSwift
import RxCocoa

class ChangeTamagotchiViewController: OnboardingViewController {

    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        print(self, "deinit")
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
    }
    
    override func configureLayout() {
        super.configureLayout()
    }
    
    override func configureView() {
        super.configureView()
        navigationItem.title = "다마고치 변경하기"
        super.startButtonTitle = "변경하기"
    }
}
