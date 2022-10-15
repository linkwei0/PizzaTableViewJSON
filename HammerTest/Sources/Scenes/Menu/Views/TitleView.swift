//
//  TitleView.swift
//  HammerTest
//

import UIKit

class TitleView: UIView {
    // MARK: - Properties
    
    private let titleLabel = Label(textStyle: .bodyBold)
    private let arrowImageView = UIImageView()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupTitleLabel()
        setupArrowImage()
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.text = "Москва"
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        titleLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
        }
    }
    
    private func setupArrowImage() {
        addSubview(arrowImageView)
        arrowImageView.contentMode = .scaleAspectFit
        arrowImageView.clipsToBounds = true
        arrowImageView.image = UIImage(named: "city-title-arrow")
        arrowImageView.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
        }
    }
}
