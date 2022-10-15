//
//  MainTabBarController.swift
//  HammerTest
//

import UIKit

typealias Tabs = (
    menu: BaseViewController,
    contact: BaseViewController,
    profile: BaseViewController,
    cart: BaseViewController
)


class TabBarController: UITabBarController {
    // MARK: - Init
    
    init(tabs: Tabs) {
        super.init(nibName: nil, bundle: nil)
        viewControllers = [tabs.menu, tabs.contact, tabs.profile, tabs.cart]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = UIColor(named: "pinkMain")
    }
}
