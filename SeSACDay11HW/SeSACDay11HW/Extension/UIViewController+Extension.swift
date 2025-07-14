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

        self.view.superview?.superview?.superview?.makeToast(message, duration: 3.0, position: .top, style: style)
    }
}
