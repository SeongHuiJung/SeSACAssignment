//
//  TamagotchiViewController.swift
//  SeSACDay8HW
//
//  Created by 정성희 on 8/22/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class TamagotchiViewController: BaseViewController {
    
    var tamagotchiType: BehaviorRelay<TamagotchiType> = BehaviorRelay(value: TamagotchiType.none)
    private let viewModel = TamagotchiViewModel()
//    private let viewModel: TamagotchiViewModel()
    private let disposeBag = DisposeBag()
    
    
    private let bubbleImage = {
        let image = UIImageView(image: UIImage(named: "bubble"))
        return image
    }()
    private let tamagotchiSpeechLabel = CustomUILabel(text: "", alignment: .center, size: 15, weight: .semibold, textColor: .primary)
    private let tamagotchiImage = {
        let image = UIImageView(image: UIImage(named: ""))
        return image
    }()
    private let tamagotchiLabel = CustomUILabel(text: "test", alignment: .center, size: 16, weight: .semibold, textColor: .primary)
    private let statusLabel = CustomUILabel(text: "", alignment: .left, size: 15, weight: .regular, textColor: .primary, numberOfLines: 1)
    private let riceTextField = CustomTextField(text: "", placeholder: "냠냠", size: 15, alignment: .center, textColor: .primary)
    private let waterTextField = CustomTextField(text: "", placeholder: "물물", size: 15, alignment: .center, textColor: .primary)
    private let lineView1 = {
        let view = UIView()
        view.backgroundColor = .primary
        return view
    }()
    private let lineView2 = {
        let view = UIView()
        view.backgroundColor = .primary
        return view
    }()
    private let riceButton = IconButton(title: "밥먹기", size: 16, textColor: .primary, iconName: "fork.knife.circle")
    private let waterButton = IconButton(title: "물먹기", size: 16, textColor: .primary, iconName: "drop.circle")
    
//    init(viewModel: TamagotchiViewModel) {
//        self.viewModel = viewModel
//    }
//    
//    @MainActor required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "\(UserDefaultsManager.userName)님의 다마고치"
    }

    override func configureHierarchy() {
        super.configureHierarchy()
        [bubbleImage, tamagotchiSpeechLabel, tamagotchiImage, tamagotchiLabel, statusLabel, riceTextField, waterTextField, lineView1, lineView2, riceButton, waterButton].forEach { view.addSubview($0) }
    }
    
    override func configureLayout() {
        super.configureLayout()
        bubbleImage.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(52)
        }
        tamagotchiSpeechLabel.snp.makeConstraints { make in
            make.edges.equalTo(bubbleImage).inset(16)
        }
        tamagotchiImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(88)
            make.height.equalTo(tamagotchiImage.snp.width)
            make.top.equalTo(bubbleImage.snp.bottom).offset(10)
        }
        tamagotchiLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(tamagotchiImage.snp.bottom).offset(10)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(tamagotchiLabel.snp.bottom).offset(12)
        }
        
        riceTextField.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(28)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(80)
            make.width.equalTo(160)
            make.height.equalTo(40)
        }
        lineView1.snp.makeConstraints { make in
            make.top.equalTo(riceTextField.snp.bottom)
            make.horizontalEdges.equalTo(riceTextField)
            make.height.equalTo(1)
        }
        riceButton.snp.makeConstraints { make in
            make.top.equalTo(riceTextField.snp.top).offset(4)
            make.left.equalTo(riceTextField.snp.right).offset(12)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        
        waterTextField.snp.makeConstraints { make in
            make.top.equalTo(riceTextField.snp.bottom).offset(12)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(80)
            make.width.equalTo(160)
            make.height.equalTo(40)
        }
        lineView2.snp.makeConstraints { make in
            make.top.equalTo(waterTextField.snp.bottom)
            make.horizontalEdges.equalTo(waterTextField)
            make.height.equalTo(1)
        }
        waterButton.snp.makeConstraints { make in
            make.top.equalTo(waterTextField.snp.top).offset(4)
            make.left.equalTo(waterTextField.snp.right).offset(12)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
    }

    override func configureView() {
        super.configureView()
        let infoButton = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(infoButtonTapped))
        navigationItem.rightBarButtonItem = infoButton
    }
}

extension TamagotchiViewController {
    func bind() {
        let input = TamagotchiViewModel.Input(tamagotchiType: tamagotchiType, riceButtonTapped: riceButton.rx.tap, addRiceAmount: riceTextField.rx.text.orEmpty, waterButtonTapped: waterButton.rx.tap, addWaterAmount: waterTextField.rx.text.orEmpty)
        let output = viewModel.transform(input: input)
        
        output.statusResult
            .bind(to: statusLabel.rx.text)
            .disposed(by: disposeBag)

        output.tamagotchiMessage
            .bind(to: tamagotchiSpeechLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.tamagotchiType
            .bind(with: self) { owner, type in
                owner.tamagotchiLabel.text = type.krName
            }
            .disposed(by: disposeBag)
        
        output.tamagotchiImage
            .bind(with: self) { owner, imageName in
                owner.tamagotchiImage.image = UIImage(named: imageName)
            }
            .disposed(by: disposeBag)
    }
    
    @objc private func infoButtonTapped() {
        navigationController?.pushViewController(SettingViewController(), animated: true)
    }
}
