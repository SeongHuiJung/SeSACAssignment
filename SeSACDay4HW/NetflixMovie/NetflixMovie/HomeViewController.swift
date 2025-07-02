//
//  HomeViewController.swift
//  NetflixMovie
//
//  Created by 정성희 on 7/2/25.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var nicknameLabel: UILabel!
    @IBOutlet var mainImage: UIImageView!
    @IBOutlet var nowFamousContentsImages: [UIImageView]!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var likeListButton: UIButton!
    @IBOutlet var nowFamousLabel: UILabel!
    
    @IBOutlet var top10Images: [UIImageView]!
    @IBOutlet var newSeriesLabels: [UILabel]!
    @IBOutlet var nowSeeLabels: [UILabel]!
    
    let imageList = ["극한직업", "노량", "더퍼스트슬램덩크", "도둑들", "명량", "밀수", "범죄도시3", "베테랑", "부산행", "서울의봄", "스즈메의문단속", "신과함께인과연", "신과함께죄와벌", "아바타", "아바타물의길", "알라딘", "암살", "어벤져스엔드게임", "오펜하이머", "왕의남자", "육사오"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setRandomImage()
        resetBadge()
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        setRandomImage()
        resetBadge()
    }
    
    func setUI() {
        nicknameLabel.text = "성희님"
        nicknameLabel.textColor = .white
        nicknameLabel.font = .systemFont(ofSize: 20,weight: .bold)
        
        nowFamousLabel.text = "지금 뜨는 콘텐츠"
        nowFamousLabel.textColor = .white
        nowFamousLabel.font = .systemFont(ofSize: 15)
        
        playButton.setTitle("재생", for: .normal)
        playButton.setTitleColor(.black, for: .normal)
        playButton.backgroundColor = .white
        playButton.titleLabel?.textAlignment = .center
        playButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        setButtonCorner(button: playButton)
        
        likeListButton.setTitle("내가 찜한 리스트", for: .normal)
        likeListButton.setTitleColor(.white, for: .normal)
        likeListButton.backgroundColor = .darkGray
        likeListButton.titleLabel?.textAlignment = .center
        likeListButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        setButtonCorner(button: likeListButton)
        
        for image in nowFamousContentsImages {
            setImageCorner(image: image)
        }
        setImageCorner(image: mainImage)
        
        for i in 0..<top10Images.count {
            top10Images[i].image = UIImage(named: "top10 badge")
        }
        
        for i in 0..<newSeriesLabels.count {
            newSeriesLabels[i].text = "새로운 시리즈"
            newSeriesLabels[i].textColor = .white
            newSeriesLabels[i].font = .systemFont(ofSize: 11)
            newSeriesLabels[i].backgroundColor = .red
            newSeriesLabels[i].textAlignment = .center
        }
        
        for i in 0..<nowSeeLabels.count {
            nowSeeLabels[i].text = "지금 시청하기"
            nowSeeLabels[i].textColor = .black
            nowSeeLabels[i].font = .systemFont(ofSize: 11)
            nowSeeLabels[i].backgroundColor = .white
            nowSeeLabels[i].textAlignment = .center
        }
    }
    
    func setImageCorner(image: UIImageView) {
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
    }
    
    func setButtonCorner(button: UIButton) {
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
    }
    
    func setRandomImage() {
        for image in nowFamousContentsImages {
            image.image = UIImage(named: imageList[Int.random(in: 0..<imageList.count)])
        }
        
        mainImage.image = UIImage(named: imageList[Int.random(in: 0..<imageList.count)])
    }
    
    func resetBadge() {
        setRandomList(list: top10Images)
        setRandomList(list: newSeriesLabels)
        setRandomList(list: nowSeeLabels)
    }
    
    func setRandomList(list: [UIImageView]) {
        for i in 0..<3 {
            let randomValue = Int.random(in: 1...3)

            if randomValue == 1 {
                list[i].isHidden = false
            }
            else {
                list[i].isHidden = true
            }
        }
    }
    
    func setRandomList(list: [UILabel]) {
        for i in 0..<3 {
            let randomValue = Int.random(in: 1...3)
            if randomValue == 1 {
                list[i].isHidden = false
            }
            else {
                list[i].isHidden = true
            }
        }
    }
}
