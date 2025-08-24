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

enum TamagotchiType {
    case tingling(level: Int)
    case smile(level: Int)
    case twinkle(level: Int)
    case none
    
    var krName: String {
        switch self {
        case .tingling: "따끔따끔 다마고치"
        case .smile: "방실방실 다마고치"
        case .twinkle: "반짝반짝 다마고치"
        case .none: "준비중이에요"
        }
    }
    
    var index: Int {
        switch self {
        case .tingling: 1
        case .smile: 2
        case .twinkle: 3
        case .none: -1
        }
    }
    
    var imageName: String {
        switch self {
        case .tingling(let level),
                .smile(let level),
                .twinkle(let level): "\(self.index)-\(level)"
        case .none: "noImage"
        }
    }
    
    var description: String {
        switch self {
        case .tingling: "저는 따끔따끔 다마고치에요\n만질때는 따끔따끔하니 조심해주세요"
        case .smile: "저는 방실방실 다마고치에요\n웃게 만들어드릴게요~~"
        case .twinkle: "저는 반짝반짝 다마고치에요\n반짝반짝 빛나용"
        case .none: "준비중이에요"
        }
    }
}

class OnboardingViewController: BaseViewController {

    var startButtonTitle = "시작하기"
    private let viewModel = OnboardingViewModel()
    
    let tamagotchiCollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionView.getLayout(scrollDirection: .vertical, cellCount: 3, gap: (20, 20), edgeInsets: (20, 32), standardTotalSize: UIScreen.main.bounds.width, fixCellSize: 160))
        collectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: OnboardingCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    private let tamagotchiListData = {
        var list = [TamagotchiType](repeating: TamagotchiType.none, count: 24)
        let existData = [TamagotchiType.tingling(level: 6),
                         TamagotchiType.smile(level: 6),
                         TamagotchiType.twinkle(level: 6)]
        list.insert(contentsOf: existData, at: 0)
        return list
    }()
    lazy private var tamagotchiList = Observable.just(tamagotchiListData)
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    deinit {
        print(self, "deinit")
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
        
        tamagotchiCollectionView.rx.modelSelected(TamagotchiType.self)
            .bind(with: self) { owner, type in
                let viewController = SelectTamagotchiViewController()
                viewController.tamagotchiType.accept(type) // TODO: 여기서는 type.. 넣는 타입이 다르다?
                viewController.startButton.setTitle(owner.startButtonTitle, for: .normal)
                viewController.modalPresentationStyle = .overCurrentContext
                owner.present(viewController, animated: false)
            }
            .disposed(by: disposeBag)
    }
}
