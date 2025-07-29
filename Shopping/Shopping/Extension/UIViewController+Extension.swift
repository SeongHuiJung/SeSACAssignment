//
//  UIViewController+Extension.swift
//  Shopping
//
//  Created by 정성희 on 7/29/25.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, ok: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: ok, style: .default)
        alert.addAction(ok)

        self.present(alert, animated: true)
    }
}
