//
//  AlertSingleton.swift
//  Shopping
//
//  Created by 정성희 on 7/29/25.
//

import UIKit

class AlertSingleton {
    static let shared = AlertSingleton()
    
    private init() {
        let button = UIAlertAction(title: "확인", style: .destructive)
        alert.addAction(button)
    }
    
    private var alert = UIAlertController(title: "", message: "", preferredStyle: .alert)

    func getAlert(title: String, message: String) -> UIAlertController {
        alert.title = title
        alert.message = message
        return alert
    }
}
