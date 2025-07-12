//
//  TravelTableViewController.swift
//  SeSACDay11HW
//
//  Created by 정성희 on 7/12/25.
//

import UIKit

class CityDetailViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension CityDetailViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityDetailTableViewCell", for: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
}
