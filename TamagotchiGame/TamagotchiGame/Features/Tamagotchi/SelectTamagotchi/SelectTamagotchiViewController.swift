//
//  SelectTamagotchiViewController.swift
//  TamagotchiGame
//
//  Created by 정성희 on 8/24/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SelectTamagotchiViewController: TamagotchiBaseViewController {

    private let disposeBag = DisposeBag()
    private var viewModel: SelectTamagotchiViewModel
    
    init(viewModel: SelectTamagotchiViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let paddingView = {
        let view = UIView()
        view.backgroundColor = .second
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    let tamagotchiImage = {
        let image = UIImageView()
        image.backgroundColor = .clear
        return image
    }()
    let namePaddingView = {
        let view = UIView()
        view.backgroundColor = .second
        view.layer.borderColor = UIColor.primary.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()
    let name = CustomUILabel(text: "test", alignment: .center, size: 13, textColor: .primary)
    let line = {
        let view = UIView()
        view.backgroundColor = .primary
        return view
    }()
    let descriptionLabel = CustomUILabel(text: "", alignment: .center, size: 15, textColor: .primary)
    let line2 = {
        let view = UIView()
        view.backgroundColor = .primary.withAlphaComponent(0.5)
        return view
    }()
    let cancelButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.primary, for: .normal)
        button.backgroundColor = .second
        return button
    }()
    let startButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitle("시작하기", for: .normal)
        button.setTitleColor(.primary, for: .normal)
        button.backgroundColor = .second
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dependencyInjection()
        bind()
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        [paddingView].forEach { view.addSubview($0) }
        [tamagotchiImage, namePaddingView, name, line, descriptionLabel, cancelButton, startButton, line2].forEach { paddingView.addSubview($0) }
    }

    override func configureLayout() {
        super.configureLayout()
        paddingView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.verticalEdges.equalTo(view.safeAreaLayoutGuide).inset(160)
        }
        tamagotchiImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
            make.size.equalTo(100)
        }
        namePaddingView.snp.makeConstraints { make in
            make.top.equalTo(tamagotchiImage.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
        name.snp.makeConstraints { make in
            make.edges.equalTo(namePaddingView).inset(8)
        }
        line.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(40)
            make.horizontalEdges.equalToSuperview().inset(48)
            make.height.equalTo(0.5)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(40)
            make.horizontalEdges.equalToSuperview().inset(48)
        }
        cancelButton.snp.makeConstraints { make in
            make.bottom.left.equalToSuperview()
            make.right.equalTo(paddingView.snp.centerX)
            make.height.equalTo(52)
        }
        startButton.snp.makeConstraints { make in
            make.bottom.right.equalToSuperview()
            make.left.equalTo(paddingView.snp.centerX)
            make.height.equalTo(52)
        }
        line2.snp.makeConstraints { make in
            make.top.equalTo(cancelButton.snp.top)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
    override func configureView() {
        super.configureView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
}

// MARK: - DI
extension SelectTamagotchiViewController {
    func dependencyInjection() {
        let type = viewModel.tamagotchiType
        tamagotchiImage.image = UIImage(named: type.imageName)
        name.text = type.krName
        descriptionLabel.text = type.description
    }
}

// MARK: - Bind
extension SelectTamagotchiViewController {
    func bind() {
        let input = SelectTamagotchiViewModel.Input(cancelButtonTap: cancelButton.rx.tap, startButtonTap: startButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.cancelButtonTap
            .bind(with: self) { owner, _ in
                owner.dismiss(animated: false)
            }
            .disposed(by: disposeBag)
        
        output.startButtonTap
            .bind(with: self) { owner, _ in
                owner.view.window?.rootViewController = TransitionManager.shared.getMainTabViewController(reSelect: true, tamagotchiType: owner.viewModel.tamagotchiType)
                owner.view.window?.makeKeyAndVisible()
            }
            .disposed(by: disposeBag)
    }
}
