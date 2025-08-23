//
//  OnboardingViewController.swift
//  SeSACDay8HW
//
//  Created by 정성희 on 8/23/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

enum TamagotchiType: Int {
    case tingling = 1
    case smile
    case twinkle
    case none = -1
    
    var krName: String {
        switch self {
        case .tingling: "따끔따끔 다마고치"
        case .smile: "방실방실 다마고치"
        case .twinkle: "반짝반짝 다마고치"
        case .none: "준비중이에요"
        }
    }
}

class OnboardingViewController: BaseViewController {

    private let viewModel = OnboardingViewModel()
    private let tamagotchiCollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionView.getLayout(scrollDirection: .vertical, cellCount: 3, gap: (20, 20), edgeInsets: (20, 32), standardTotalSize: UIScreen.main.bounds.width, fixCellSize: 160))
        collectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: OnboardingCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    private let tamagotchiListData = {
        var list = [TamagotchiType](repeating: TamagotchiType.none, count: 24)
        let existData = [TamagotchiType(rawValue: 1)!,
                    TamagotchiType(rawValue: 2)!,
                    TamagotchiType(rawValue: 3)!]
        list.insert(contentsOf: existData, at: 0)
        return list
    }()
    lazy private var tamagotchiList = Observable.just(tamagotchiListData)
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        [tamagotchiCollectionView].forEach { view.addSubview($0) }
    }
    
    override func configureLayout() {
        super.configureLayout()
        tamagotchiCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        super.configureView()
        navigationItem.title = "다마고치 선택하기"
    }
}

extension OnboardingViewController {
    private func bind() {
        tamagotchiList.bind(to: tamagotchiCollectionView.rx.items(cellIdentifier: OnboardingCollectionViewCell.identifier, cellType: OnboardingCollectionViewCell.self)) { index, value, cell in
            cell.configureData(tamagotchiType: value)
        }
        .disposed(by: disposeBag)
    }
}
