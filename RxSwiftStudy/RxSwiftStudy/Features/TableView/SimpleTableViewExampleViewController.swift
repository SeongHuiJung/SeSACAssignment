//
//  ViewController.swift
//  RxSwiftStudy
//
//  Created by 정성희 on 8/19/25.
//

import UIKit
import RxSwift
import RxCocoa

class SimpleTableViewExampleViewController: UIViewController, UITableViewDelegate {

    private let tableView = {
        let view = UITableView()
         view.register(SimpleTableViewCell.self, forCellReuseIdentifier: SimpleTableViewCell.identifier)
         view.backgroundColor = .lightGray
         view.rowHeight = 44
        return view
      }()
    
    private let disposeBag = DisposeBag()
    let items = Observable.just((0..<20).map { "\($0)" })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self, #function)
        configure()
        
        items
            .bind(to: tableView.rx.items(cellIdentifier: SimpleTableViewCell.identifier, cellType: SimpleTableViewCell.self)) { (row, element, cell) in // 왜 자동으로 클로저가 안나오지?
                cell.label.text = "\(element) @ row \(row)"
            }
            .disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(String.self)
            .subscribe(with: self) { owner, value in
                let alert = UIAlertController(title: "정보", message: "\(value)를 눌렀습니다", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .destructive)
                alert.addAction(ok)

                owner.present(alert, animated: true)
            }
            .disposed(by: disposeBag)

        // TODO: Detail 버튼 UI에 왜 안나오는지 확인
        tableView.rx
            .itemAccessoryButtonTapped
            .subscribe(with: self) { owner, indexPath in
                let alert = UIAlertController(title: "디테일 정보", message: "\(indexPath)를 눌렀습니다", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .destructive)
                alert.addAction(ok)

                owner.present(alert, animated: true)
            }
            .disposed(by: disposeBag)
    }

    private func configure() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
