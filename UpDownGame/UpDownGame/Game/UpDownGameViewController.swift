//
//  UpDownGameViewController.swift
//  UpDownGame
//
//  Created by 정성희 on 7/20/25.
//

import UIKit

class UpDownGameViewController: UIViewController {

    static let identifier = "UpDownGameViewController"
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var tryCountLabel: UILabel!
    @IBOutlet var startButton: UIButton!
    
    var max = 0
    var answer = 0
    var selectedIndex = -1
    var gameList: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setGameAnswer()
    }
}

// MARK: - Action
extension UpDownGameViewController {
    @IBAction func startButtonTapped(_ sender: UIButton) {
        guard selectedIndex != -1 else { return }
        
        if gameList[selectedIndex] == answer {
            resultLabel.text = "Good!"
        }
        else if gameList[selectedIndex] > answer {
            resultLabel.text = "Down"
            tryCountLabel.text = String(Int(tryCountLabel.text ?? "0")! + 1)
            deleteUpData(index: selectedIndex)
            fetchData()
        }
        else if gameList[selectedIndex] < answer {
            resultLabel.text = "Up"
            tryCountLabel.text = String(Int(tryCountLabel.text ?? "0")! + 1)
            deleteDownData(index: selectedIndex)
            fetchData()
        }
        else {
            print("error")
        }
    }
}

// MARK: - Logic
extension UpDownGameViewController {
    func setGameAnswer() {
        answer = Int.random(in: 1...max)
        gameList = Array(1...max)
    }
    
    func fetchData() {
        collectionView.reloadData()
    }
    
    func deleteUpData(index: Int) {
        gameList = Array(gameList[0..<index])
    }
    
    func deleteDownData(index: Int) {
        gameList = Array(gameList[(index + 1)...])
    }
}

// MARK: - Collection View Delegate
extension UpDownGameViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        gameList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpDownGameCollectionViewCell.identifier, for: indexPath) as! UpDownGameCollectionViewCell
        
        cell.configure(value: String(gameList[indexPath.item])) // String(indexPath.row + 1)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedItem = collectionView.indexPathsForSelectedItems?[0] {
            selectedIndex = selectedItem.item
        }
    }
}

// MARK: - UI / Standard Set
extension UpDownGameViewController {
    func configure() {
        setNib(identifier: UpDownGameCollectionViewCell.identifier, object: collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.collectionViewLayout = getLayout()
        collectionView.backgroundColor = .clear
        setButtonUI()

        view.backgroundColor = .systemMint
    }
    
    private func getLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let collectionViewHeight = collectionView.bounds.height
        
        let heightCellCount: CGFloat = 5
        let gap: CGFloat = 8
        
        let cellheight: Double = collectionViewHeight - (gap * 2) - (gap * (heightCellCount - 1))
        layout.itemSize = CGSize(width: cellheight / heightCellCount, height: cellheight / heightCellCount)
        layout.sectionInset = UIEdgeInsets(top: gap, left: gap, bottom: gap, right: gap)
        layout.minimumLineSpacing = gap
        layout.minimumInteritemSpacing = gap
        layout.scrollDirection = .horizontal
        
        return layout
    }
    
    private func setButtonUI() {
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        startButton.setTitleColor(.white, for: .normal)
        startButton.backgroundColor = .black
        startButton.layer.cornerRadius = 10
        startButton.clipsToBounds = true
    }
}
