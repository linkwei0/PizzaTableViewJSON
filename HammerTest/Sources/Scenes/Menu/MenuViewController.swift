//
//  MenuViewController.swift
//  HammerTest
//

import UIKit

protocol MenuViewProtocol: AnyObject {
    func updateTable()
    func showCategory(_ indexPath: IndexPath)
}

class MenuViewController: BaseViewController {
    // MARK: - Properties
    
    private var previousOffset: CGPoint?
    private var topViewHeightConstraint: NSLayoutConstraint?
    private var viewHeight: CGFloat = 145
    
    private let cityView = TitleView()
    private let bannerScrollView = UIScrollView()
    private let bannerStackView = UIStackView()
    private let categoryScrollView = UIScrollView()
    private let categoryStackView = UIStackView()
    private let containerView = UIView()
    private let tableView = UITableView()
    private let tabBar = UITabBar()
    
    private let presenter: MenuPresenterProtocol
        
    // MARK: - Init
    
    init(presenter: MenuPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter.viewDidLoaded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        previousOffset = bannerScrollView.contentOffset
        topViewHeightConstraint = bannerScrollView.constraints.first
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupCityView()
        setupBannerScrollView()
        setupBannerStackView()
        setupCategoryScrollView()
        setupCategoryStackView()
        setupCategoryView()
        setupBannerView()
        setupContainerView()
        setupTableView()
        setupTabBar()
    }
    
    private func setupCityView() {
        view.addSubview(cityView)
        cityView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(64)
            make.left.equalToSuperview().inset(32)
        }
    }
    
    private func setupBannerScrollView() {
        view.addSubview(bannerScrollView)
        bannerScrollView.showsHorizontalScrollIndicator = false
        bannerScrollView.isPagingEnabled = true
        bannerScrollView.contentInsetAdjustmentBehavior = .never
        bannerScrollView.snp.makeConstraints { make in
            make.top.equalTo(cityView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(145)
        }
    }
    
    private func setupBannerStackView() {
        bannerScrollView.addSubview(bannerStackView)
        bannerStackView.axis = .horizontal
        bannerStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(145)
        }
    }
    
    private func setupCategoryScrollView() {
        view.addSubview(categoryScrollView)
        categoryScrollView.showsHorizontalScrollIndicator = false
        categoryScrollView.isPagingEnabled = true
        categoryScrollView.contentInsetAdjustmentBehavior = .never
        categoryScrollView.snp.makeConstraints { make in
            make.top.equalTo(bannerScrollView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    private func setupCategoryStackView() {
        categoryScrollView.addSubview(categoryStackView)
        categoryStackView.spacing = 16
        categoryStackView.axis = .horizontal
        categoryStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(32)
            make.height.equalTo(38)
        }
    }
    
    private func setupCategoryView() {
        categoryStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        presenter.categoryViews.forEach { categoryView in
            categoryStackView.addArrangedSubview(categoryView)
            categoryView.snp.makeConstraints { make in
                make.width.equalTo(95)
            }
        }
    }
    
    private func setupBannerView() {
        presenter.bannerViews.forEach { bannerView in
            bannerStackView.addArrangedSubview(bannerView)
            bannerView.snp.makeConstraints { make in
                make.width.equalTo(325)
            }
        }
    }
    
    private func setupContainerView() {
        view.addSubview(containerView)
        containerView.backgroundColor = .white
        containerView.addShadow(offset: CGSize(width: 0, height: 4), radius: 24, color: .black, opacity: 0.2)
        containerView.layer.cornerRadius = 24
        containerView.snp.makeConstraints { make in
            make.top.equalTo(categoryScrollView.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupTableView() {
        containerView.addSubview(tableView)
        tableView.register(MenuCell.self, forCellReuseIdentifier: MenuCell.reuseIdentifier)
        tableView.rowHeight = 175
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupTabBar() {
        view.addSubview(tabBar)
        tabBar.backgroundColor = .red
        tabBar.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
    }
}

// MARK: - MenuViewProtocol

extension MenuViewController: MenuViewProtocol {
    func showCategory(_ indexPath: IndexPath) {
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    func updateTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.setupCategoryView()
        }
    }
}

// MARK: - UITableViewDataSource

extension MenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.arrayOfFood.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.reuseIdentifier,
                                                       for: indexPath) as? MenuCell else { return UITableViewCell() }
        cell.configure(with: presenter.configureCell(indexPath: indexPath))
        return cell
    }
}

// MARK: - UITableViewDelegate/UIScrollViewDelegate

extension MenuViewController: UITableViewDelegate, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tapped on -", presenter.arrayOfFood[indexPath.row].name)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let topViewHeightConstraint = topViewHeightConstraint else { return }
        let currentOffset = scrollView.contentOffset
        if let startOffset = previousOffset {
            let delta = abs((startOffset.y - currentOffset.y))
          
            if currentOffset.y > startOffset.y, currentOffset.y > .zero {
                var newHeight = topViewHeightConstraint.constant - delta
                
                if newHeight < .zero {
                    newHeight = .zero
                }
                topViewHeightConstraint.constant = newHeight
            } else if currentOffset.y < startOffset.y, currentOffset.y <= viewHeight {
                var newHeight = topViewHeightConstraint.constant + delta
                
                if newHeight > viewHeight {
                    newHeight = viewHeight
                }
                topViewHeightConstraint.constant = newHeight
            }
            previousOffset = scrollView.contentOffset
            self.view.layoutIfNeeded()
        }
    }
}
