//
//  TravelTableViewController.swift
//  SeSACDay11HW
//
//  Created by 정성희 on 7/12/25.
//

import UIKit
import Kingfisher
import Toast

// baseViewController : UIViewController/
// adBackgroundColorList 넣기

class CityDetailTableViewController: UITableViewController {

    var travelData = TravelInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var xib = UINib(nibName: "AdTableViewCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "AdTableViewCell")
        
        xib = UINib(nibName: "CityDetailTableViewCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "CityDetailTableViewCell")
    }
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        if let like = travelData.travel[sender.tag].like {
            travelData.travel[sender.tag].like = !like
        }
        else {
            // protocol Collection
            travelData.travel[sender.tag].like = true
        }
        
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
    }
}

extension CityDetailTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelData.travel.count
    }
    
    func getDefaultCell(indexPath: IndexPath, row: Travel) -> CityDetailTableViewCell {
        // static 으로 관리하기
        // enum
        // String(description...)
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityDetailTableViewCell", for: indexPath) as! CityDetailTableViewCell
        
        cell.configureDefaultCellUI(row: travelData.travel[indexPath.row])
        
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        return cell
    }
    
    func getAdvertisementCell(indexPath: IndexPath, row: Travel) -> AdTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdTableViewCell", for: indexPath) as! AdTableViewCell
        
        cell.configureAdCellUI(row: travelData.travel[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = travelData.travel[indexPath.row]
        
        if row.ad == false {
            return getDefaultCell(indexPath: indexPath, row: row)
        }
        else {
            return getAdvertisementCell(indexPath: indexPath, row: row)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if travelData.travel[indexPath.row].ad == false { return 200 }
        else { return 100 }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if travelData.travel[indexPath.row].ad == true {
            self.makeToast("광고입니다")
        }
    }
}
