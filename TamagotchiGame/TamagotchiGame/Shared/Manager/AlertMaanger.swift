//
//  AlertMaanger.swift
//  TamagotchiGame
//
//  Created by 정성희 on 8/26/25.
//

import UIKit

class AlertMaanger {
    static let shared = AlertMaanger()
    private init() {}
    
    func makeAlert(titel: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: titel, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .destructive)
        alert.addAction(ok)
        return alert
    }
}
