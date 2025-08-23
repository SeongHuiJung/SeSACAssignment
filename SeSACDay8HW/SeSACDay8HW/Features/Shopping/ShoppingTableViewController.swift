//
//  ShoppingTableViewController.swift
//  SeSACDay8HW
//
//  Created by 정성희 on 7/10/25.
//

import UIKit

struct Shop {
    var title: String
    var isBookmark: Bool = false
    var isCompleted: Bool = false
    var uuid: Int
}

class ShoppingTableViewController: UITableViewController {
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var addButton: UIButton!
    
    // 각 물건에 붙일 고유번호
    var uuid = 0
    
    // shopList[0] : 사야되는 물건
    // shopList[1] : 산 물건
    var shopList: [[Shop]] = [[],[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// test set
        setTestcase()
        //setTestcase2()
        //setTestcase3()
        //setTestcase4()
        
        setTextFieldUI()
        setButtonUI()
    }
    
    func setTestcase() {
        shopList = [[Shop(title: "양말", uuid: 0), Shop(title: "연필", uuid: 1), Shop(title: "컴퓨터", uuid: 2)],
        [Shop(title: "가위", isCompleted: true, uuid: 3)]]
        
        uuid = 4
    }
    func setTestcase2() {
        shopList = [[Shop(title: "양말", uuid: 0)],
        [Shop(title: "가위", isCompleted: true, uuid: 1)]]
        
        uuid = 2
    }
    func setTestcase3() {
        shopList = [[Shop(title: "양말", uuid: 0)],[]]
        
        uuid = 1
    }
    func setTestcase4() {
        shopList = [[],[Shop(title: "양말", isCompleted: true, uuid: 0)]]
        
        uuid = 1
    }
    
    @objc func completeButtonTapped(_ sender: UIButton) {
        stop: for i in 0..<shopList.count {
            for j in 0..<shopList[i].count {
                if shopList[i][j].uuid == sender.tag {
                    shopList[i][j].isCompleted = !shopList[i][j].isCompleted
                    
                    // 안 산 물건 -> 산 물건 배열로 이동
                    if shopList[i][j].isCompleted {
                        shopList[1].append(shopList[0].remove(at: j))
                    }
                    
                    // 산 물건 -> 안 산 물건 배열로 이동
                    else {
                        shopList[0].append(shopList[1].remove(at: j))
                    }
                    
                    break stop
                }
            }
        }
        
        // 물건 이름별로 오름차순 정렬
        shopList[0].sort { $0.title < $1.title }
        shopList[1].sort { $0.title < $1.title }
        
        tableView.reloadData()
    }
    @objc func bookmarkButtonTapped(_ sender: UIButton) {
        stop: for i in 0..<shopList.count {
            for j in 0..<shopList[i].count {
                if shopList[i][j].uuid == sender.tag {
                    shopList[i][j].isBookmark = !shopList[i][j].isBookmark
                    
                    break stop
                }
            }
        }
        tableView.reloadData()
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        guard let text = searchTextField.text else {
            print("올바르지 않은 입력입니다")
            return
        }
        
        if !text.isEmpty {
            shopList[0].append(Shop(title: text, uuid: uuid))
            uuid += 1
            tableView.reloadData()
        }
    }
    
    func setTextFieldUI() {
        searchTextField.attributedPlaceholder = NSAttributedString(string: "무엇을 구매하실 건가요?", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray4])
        searchTextField.backgroundColor = .systemGray6
        searchTextField.font = .systemFont(ofSize: 13)
        searchTextField.textColor = .systemGray2
        
        searchTextField.layer.cornerRadius = 5
        searchTextField.clipsToBounds = true
        
        searchTextField.borderStyle = .none
        
        // 입력하는 부분 왼쪽에 간격 추가
        searchTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 0.0))
        searchTextField.leftViewMode = .always
    }
    func setButtonUI() {
        addButton.setTitle("추가", for: .normal)
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        addButton.setTitleColor(.black, for: .normal)
        addButton.backgroundColor = .systemGray4
        addButton.layer.cornerRadius = 5
        addButton.clipsToBounds = true
    }
}

extension ShoppingTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        shopList.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopList[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell", for: indexPath) as! ShoppingTableViewCell
        print(#function)
        cell.titleLabel.text = shopList[indexPath.section][indexPath.row].title
        cell.cellView.layer.cornerRadius = 10
        
        cell.completeButton.tag = shopList[indexPath.section][indexPath.row].uuid
        cell.bookMarkButton.tag = shopList[indexPath.section][indexPath.row].uuid
        
        cell.bookMarkButton.addTarget(self, action: #selector(bookmarkButtonTapped), for: .touchUpInside)
        cell.completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
        
        if shopList[indexPath.section][indexPath.row].isCompleted {
            cell.completeButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        } else {
            cell.completeButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        }
        
        if shopList[indexPath.section][indexPath.row].isBookmark {
            cell.bookMarkButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            cell.bookMarkButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        shopList[indexPath.section].remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
        if section == 0 { return "사야할 물건" }
        else { return "산 물건" }
    }
}
