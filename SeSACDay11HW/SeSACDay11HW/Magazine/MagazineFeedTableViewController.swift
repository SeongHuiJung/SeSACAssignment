//
//  ViewController.swift
//  SeSACDay11HW
//
//  Created by 정성희 on 7/11/25.
//

import UIKit
import Kingfisher

class MagazineFeedTableViewController: UITableViewController {

    let magazineData = MagazineInfo()
    let formatStringToDate = DateFormatter()
    let formatDateToString = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        formatStringToDate.dateFormat = "yyMMdd"
        formatDateToString.dateFormat = "yy년 M월 d일"

        let xib = UINib(nibName: "MagazineTableViewCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "MagazineTableViewCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        magazineData.magazine.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MagazineTableViewCell", for: indexPath) as! MagazineTableViewCell

        let url = URL(string: magazineData.magazine[indexPath.row].photo_image)
        cell.photoImage.kf.setImage(with: url)
        cell.titleLabel.text = magazineData.magazine[indexPath.row].title
        cell.subtitleLabel.text = magazineData.magazine[indexPath.row].subtitle
        cell.dateLabel.text = magazineData.magazine[indexPath.row].date
        
        let date = formatStringToDate.date(from: cell.dateLabel.text ?? "") ?? Date()
        let dateString = formatDateToString.string(from: date)
        
        cell.dateLabel.text = dateString
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

