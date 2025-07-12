//
//  TravelTableViewController.swift
//  SeSACDay11HW
//
//  Created by 정성희 on 7/12/25.
//

import UIKit
import Kingfisher

class CityDetailViewController: UITableViewController {

    var travelData = TravelInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension CityDetailViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelData.travel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityDetailTableViewCell", for: indexPath) as! CityDetailTableViewCell
        
        cell.titleLabel.text = travelData.travel[indexPath.row].title
        cell.descriptionLabel.text = travelData.travel[indexPath.row].description
        
        if let saveCount = travelData.travel[indexPath.row].save  {
            cell.saveLabel.text = "저장 \(String(saveCount))"
        }
        else {
            cell.saveLabel.text = "저장 0"
        }
        
        if let url = URL(string: travelData.travel[indexPath.row].travel_image ?? "") {
            cell.travelImage.kf.setImage(with: url)
        }
        else {
            cell.travelImage.image = UIImage(systemName: "xmark.diamond.fill")
        }
        
        if travelData.travel[indexPath.row].like == true {
            cell.likeImage.image = UIImage(systemName: "heart.fill")
        }
        else {
            cell.likeImage.image = UIImage(systemName: "heart")
        }
        
        if let grade = travelData.travel[indexPath.row].grade {
            let grade = Int(round(grade))
            for i in 0..<grade {
                cell.gradeCollection[i].tintColor = .yellow
            }
        }
        else {
            for i in 0..<5 {
                cell.gradeCollection[i].tintColor = .systemGray4
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
}
