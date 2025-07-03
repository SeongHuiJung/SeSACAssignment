//
//  CustomNavigationController.swift
//  NetflixMovie
//
//  Created by 정성희 on 7/2/25.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }
}


// 1. 다크모드로 바꾸면 이렇게 안해도 깜빡거리지 않는다 그에 대한 이유
// 2. 첫 실행때만 깜빡거리고 이후는 괜찮을 수도 있음 이는 탭 바 컨트롤러의 생명주기와 관련이 있다
