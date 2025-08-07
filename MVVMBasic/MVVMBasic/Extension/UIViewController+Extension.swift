//
//  UIViewController+Extension.swift
//  MVVMBasic
//
//  Created by 정성희 on 8/8/25.
//

import UIKit

extension UIViewController {
    func makeAlert(message: String) {
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        let checkButton = UIAlertAction(title: "확인", style: .destructive)
        alert.addAction(checkButton)

        present(alert, animated: true)
    }
}
