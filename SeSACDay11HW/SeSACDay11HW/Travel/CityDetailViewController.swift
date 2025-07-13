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
    
    let adBackgroundColorList: [UIColor] = [.yellow, .systemPink, .systemBlue, .systemMint]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func getCommaNum(value: String) -> String {
        var result = value
        for i in 1...value.count {
            if i % 3 == 0 {
                let index = result.index(result.startIndex, offsetBy: value.count - i)
                result.insert(",", at: index)
            }
        }
        
       return result
    }
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        if let like = travelData.travel[sender.tag].like {
            travelData.travel[sender.tag].like = !like
        }
        else {
            travelData.travel[sender.tag].like = true
        }
        
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
    }
}

extension CityDetailViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelData.travel.count
    }
    
    func getDefaultCell(indexPath: IndexPath) -> CityDetailTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityDetailTableViewCell", for: indexPath) as! CityDetailTableViewCell
        
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        cell.titleLabel.text = travelData.travel[indexPath.row].title
        cell.descriptionLabel.text = travelData.travel[indexPath.row].description
        
        if let saveCount = travelData.travel[indexPath.row].save  {
            let commaNum = getCommaNum(value: String(saveCount))
            cell.saveLabel.text = "저장 \(commaNum)"
        }
        else {
            cell.saveLabel.text = "저장 0"
        }
        
        if let url = URL(string: travelData.travel[indexPath.row].travel_image ?? "") {
            cell.travelImage.kf.indicatorType = .activity
            cell.travelImage.kf.setImage(with: url)
        }
        else {
            cell.travelImage.image = UIImage(systemName: "xmark.diamond.fill")
        }
        
        if travelData.travel[indexPath.row].like == true {
            cell.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        else {
            cell.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
        if let grade = travelData.travel[indexPath.row].grade {
            let grade = Int(round(grade))
            for i in 0..<grade {
                cell.gradeCollection[i].tintColor = .yellow
            }
        }
        
        return cell
    }
    
    func getAdvertisementCell(indexPath: IndexPath) -> AdTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdTableViewCell", for: indexPath) as! AdTableViewCell
        
        cell.advertisementLabel.text = travelData.travel[indexPath.row].title
        cell.backgroundColor = adBackgroundColorList.randomElement()
        cell.selectionStyle = .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if travelData.travel[indexPath.row].ad == false {
            return getDefaultCell(indexPath: indexPath)
        }
        else {
            return getAdvertisementCell(indexPath: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if travelData.travel[indexPath.row].ad == false { return 200 }
        else { return 100 }
    }
}
