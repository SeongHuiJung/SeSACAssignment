//
//  UIView+Custom.swift
//  MVVMBasic
//
//  Created by 정성희 on 8/11/25.
//

import UIKit
import SnapKit

class ProfileSetView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let profileButton = ProfileButton(buttonImage: UIImage(systemName: "person.fill")!)
    let cameraButton = CameraButton()
    
    init() {
        super.init(frame: .zero)
        
        self.addSubview(profileButton)
        self.addSubview(cameraButton)
        
        profileButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        cameraButton.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview()
            make.size.equalTo(30)
        }
        
        self.backgroundColor = .clear
    }
}
