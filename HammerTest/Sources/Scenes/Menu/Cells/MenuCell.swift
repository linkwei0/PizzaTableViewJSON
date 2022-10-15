//
//  MenuCell.swift
//  HammerTest
//

import UIKit

class MenuCell: UITableViewCell {
    // MARK: - Properties
    
    private let mainImage = UIImageView()
    private let titleLabel = Label(textStyle: .bodyBold)
    private let descriptionLabel = Label(textStyle: .footnote)
    private let containerView = UIView()
    private let priceLabel = Label(textStyle: .body)
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    func configure(with food: Food) {
        mainImage.image = UIImage(named: "moc-image-pizza")
        titleLabel.text = food.name
        descriptionLabel.text = "Ветчина, шампиньоны, увеличенная порция моцареллы, томатный соус"
        priceLabel.text = "от \(food.price) р"
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupMainImage()
        setupBoldTitleLabel()
        setupDescriptionLabel()
        setupContainerView()
        setupPriceLabel()
    }
    
    private func setupMainImage() {
        contentView.addSubview(mainImage)
        mainImage.contentMode = .scaleAspectFit
        mainImage.clipsToBounds = true
        mainImage.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
            make.size.equalTo(125)
        }
    }
    
    private func setupBoldTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.leading.equalTo(mainImage.snp.trailing).offset(16)
        }
    }
    
    private func setupDescriptionLabel() {
        contentView.addSubview(descriptionLabel)
        descriptionLabel.textAlignment = .left
        descriptionLabel.textColor = .lightGray
        descriptionLabel.numberOfLines = 0
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.trailing.equalToSuperview().inset(16)
            make.leading.equalTo(mainImage.snp.trailing).offset(16)
        }
    }
    
    private func setupContainerView() {
        contentView.addSubview(containerView)
        containerView.backgroundColor = .white
        containerView.layer.borderWidth = 1.0
        containerView.layer.borderColor = UIColor(named: "pinkMain")?.cgColor
        containerView.alpha = 0.6
        containerView.layer.cornerRadius = 8
        containerView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(12)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(28)
            make.width.equalTo(105)
        }
    }
    
    private func setupPriceLabel() {
        containerView.addSubview(priceLabel)
        priceLabel.textColor = UIColor(named: "pinkMain")
        priceLabel.alpha = 0.6
        priceLabel.textAlignment = .center
        priceLabel.numberOfLines = 0
        priceLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
