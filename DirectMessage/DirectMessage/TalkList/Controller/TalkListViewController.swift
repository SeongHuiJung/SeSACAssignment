//
//  TalkListViewController.swift
//  DirectMessage
//
//  Created by 정성희 on 7/19/25.
//

import UIKit

class TalkListViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var chatNavigationItem: UINavigationItem!
    
    var listData = ChatList.list
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

// MARK: - Logic
extension TalkListViewController {
    func filterChatList() {
        guard let text = searchBar.text else { return }
        let entireList = ChatList.list
        
        var filteredList: [ChatRoom] = []
        
        for chat in entireList {
            if chat.chatroomName.contains(text) {
                filteredList.append(chat)
            }
        }
        
        listData = filteredList
    }
}

// MARK: - UI & Standard Setting
extension TalkListViewController {
    private func configure() {
        setNib(identifier: TalkListCollectionViewCell.identifier, object: collectionView)
        setDelegate()
        setNavigationUI()
        collectionView.collectionViewLayout = getLayout()
    }
    
    private func setDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func getLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let deviceWidth = UIScreen.main.bounds.width
        
        let widthCellCount: CGFloat = 1
        let gap: CGFloat = 8
        
        let cellWidth: Double = deviceWidth - (gap * 2) - (gap * (widthCellCount - 1))
        layout.itemSize = CGSize(width: cellWidth / widthCellCount, height: 80)
        layout.sectionInset = UIEdgeInsets(top: gap, left: gap, bottom: gap, right: gap)
        layout.minimumLineSpacing = gap
        layout.minimumInteritemSpacing = gap
        layout.scrollDirection = .vertical
        
        return layout
    }
    
    private func setNavigationUI() {
        chatNavigationItem.title = "TRAVEL TALK"
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .black
    }
}

// MARK: - Collection View
extension TalkListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        listData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TalkListCollectionViewCell.identifier, for: indexPath) as! TalkListCollectionViewCell
        cell.configureData(listData[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: ChattingRoomViewController.identifier) as! ChattingRoomViewController
        
        viewController.chatData = listData[indexPath.item]
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - Search Bar Delegate
extension TalkListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text else { return }
        if !text.isEmpty {
            filterChatList()
        } else {
            listData = ChatList.list
        }
        
        collectionView.reloadData()
    }
}
