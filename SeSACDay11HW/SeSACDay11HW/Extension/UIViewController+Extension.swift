//
//  UIViewController+Extension.swift
//  SeSACDay11HW
//
//  Created by 정성희 on 7/14/25.
//

import UIKit
import Toast

extension UIViewController {
    func makeToast(_ message: String) {
        var style = ToastStyle()

        style.messageColor = .white
        style.backgroundColor = .systemBlue

        // 화면 이동시에도 최상단에 토스트를 띄우는 방법은 없을까?
        self.tabBarController?.view.makeToast(message, duration: 3.0, position: .top, style: style)
    }
    
    func setButtonUI(_ button: UIButton, text: String) {
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
    }
}
