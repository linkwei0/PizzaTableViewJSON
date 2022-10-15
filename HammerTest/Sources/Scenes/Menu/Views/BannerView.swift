//
//  BannerView.swift
//  HammerTest
//

import UIKit

class BannerView: UIView {
    // MARK: - Properties
    
    private let mainBannerImage = UIImageView()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupMainBannerImage()
    }
    
    private func setupMainBannerImage() {
        addSubview(mainBannerImage)
        mainBannerImage.image = UIImage(named: "moc-image-1")
        mainBannerImage.clipsToBounds = true
        mainBannerImage.contentMode = .scaleAspectFit
        mainBannerImage.layer.cornerRadius = 10
        mainBannerImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
