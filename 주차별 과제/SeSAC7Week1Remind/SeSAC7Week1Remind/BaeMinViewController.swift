//
//  BaeMinViewController.swift
//  SeSAC7Week1Remind
//
//  Created by 정성희 on 7/7/25.
//

import UIKit

class BaeMinViewController: UIViewController {

    @IBOutlet var contentLabel: [UILabel]!
    let contentList = ["세상은 넓고 \n맛집은 많다", "배민원, 한 번에\n한 집만 빠르게", "가까운 가게는 직접 가지러 가요", "장보기도\n즉시배달", "멕시카나!총\n7천원 혜택", "배민 상품권\n선물해 보세요", "동네 맛집을\n넘어서"]
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelUI()
    }
    
    func setLabelUI() {
        for i in 0..<contentList.count {
            contentLabel[i].numberOfLines = 0
            contentLabel[i].text = contentList[i]
        }
    }
}
