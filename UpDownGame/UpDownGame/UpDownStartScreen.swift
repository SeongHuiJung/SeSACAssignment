//
//  ViewController.swift
//  UpDownGame
//
//  Created by 정성희 on 7/20/25.
//

import UIKit

class UpDownStartScreen: UIViewController {

    @IBOutlet var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()     
    }

    @IBAction func textFieldReturn(_ sender: UITextField) { }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        guard let text = textField.text else { return }
        if !text.isEmpty && Int(text) != nil && Int(text)! <= 10000000 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: UpDownGameViewController.identifier) as! UpDownGameViewController
            
            viewController.max = Int(text)!
            
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
