//
//  SearchMovieTableViewCell.swift
//  NetworkProject
//
//  Created by 정성희 on 7/23/25.
//

import UIKit

class SearchMovieTableViewCell: UITableViewCell {

    static let identifier = "SearchMovieTableViewCell"
    
    let indexLabel = UILabel()
    let titleLabel = UILabel()
    let dateLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
        configureView()
        setPriority()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchMovieTableViewCell: ViewDesignProtocol {
    func configureHierarchy() {
        [indexLabel, titleLabel, dateLabel].forEach { contentView.addSubview($0) }
    }
    
    func configureLayout() {
        indexLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left).offset(20)
            make.verticalEdges.equalTo(contentView).inset(10)
            make.width.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(indexLabel.snp.right).offset(20)
            make.right.equalTo(dateLabel.snp.left).offset(-20)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(contentView.snp.right).offset(-20)
        }
    }
    
    func configureView() {
        contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        
        indexLabel.font = .systemFont(ofSize: 16)
        indexLabel.textColor = .black
        indexLabel.textAlignment = .center
        indexLabel.backgroundColor = .white
        
        
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        titleLabel.backgroundColor = .clear
        
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .white
        dateLabel.textAlignment = .right
    }
    
    func setPriority() {
        dateLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
}

extension SearchMovieTableViewCell {
    func configure(index: String, item: Movie) {
        indexLabel.text = index
        titleLabel.text = item.title
        dateLabel.text = item.getFormattedDateString
    }
}
