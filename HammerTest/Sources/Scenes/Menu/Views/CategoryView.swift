//
//  CategoryView.swift
//  HammerTest
//

import UIKit

class CategoryView: UIView {
    // MARK: - Properties
    
    var onDidTap: ((_ category: Category) -> Void)?
    
    private let containerView = UIView()
    private let categoryTitleLabel = Label(textStyle: .body)
    
    var category: Category?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "pinkMain")
        layer.borderWidth = 1.0
        layer.borderColor = UIColor(named: "pinkMain")?.cgColor
        layer.cornerRadius = 20
        setup()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tap)
    }
    
    @objc private func handleTap() {
        guard let category = category else { return }
        onDidTap?(category)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    func configure(with category: Category) {
        self.category = category
        categoryTitleLabel.text = category.text
        categoryTitleLabel.alpha = category.isSelected ? 1.0 : 1
        categoryTitleLabel.font = category.isSelected ? .bodyBold : .body
        categoryTitleLabel.textColor = category.isSelected ? UIColor(named: "pinkBold") : UIColor(named: "pinkMain")
        backgroundColor = category.isSelected ? UIColor(named: "pinkMain") : .white
        alpha = category.isSelected ? 0.6 : 0.4
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupTitle()
    }
    
    private func setupTitle() {
        addSubview(categoryTitleLabel)
        categoryTitleLabel.textColor = UIColor(named: "pinkMain")
        categoryTitleLabel.textAlignment = .center
        categoryTitleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
    }
}
