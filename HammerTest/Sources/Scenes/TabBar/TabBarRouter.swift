//
//  TabBarRouter.swift
//  HammerTest
//

import UIKit

class TabBarRouter {
    typealias Submodules = (
        menu: BaseViewController,
        contact: BaseViewController,
        profile: BaseViewController,
        cart: BaseViewController
    )
    
    // MARK: - Properties
    
    weak var viewController: BaseViewController?
    private let submodules: Submodules
    
    // MARK: - Init
    
    init(submodules: Submodules) {
        self.submodules = submodules
    }
}

// MARK: - Configure TabBarItems

extension TabBarRouter {
    static func tabs(_ viewControllers: Submodules) -> Tabs {
        let menuTabBarItem = UITabBarItem(title: "", image: UIImage(named: "tabbar-menu"),
                                          selectedImage: UIImage(named: "tabbar-menu"))
        let contactTabBarItem = UITabBarItem(title: "", image: UIImage(named: "tabbar-contact"),
                                             selectedImage: UIImage(named: "tabbar-contact"))
        let profileTabBarItem = UITabBarItem(title: "", image: UIImage(named: "tabbar-profile"),
                                             selectedImage: UIImage(named: "tabbar-profile"))
        let cartTabBarItem = UITabBarItem(title: "", image: UIImage(named: "tabbar-cart"),
                                          selectedImage: UIImage(named: "tabbar-cart"))
        
        viewControllers.menu.tabBarItem = menuTabBarItem
        viewControllers.contact.tabBarItem = contactTabBarItem
        viewControllers.profile.tabBarItem = profileTabBarItem
        viewControllers.cart.tabBarItem = cartTabBarItem
        
        return (
            menu: viewControllers.menu,
            contact: viewControllers.contact,
            profile: viewControllers.profile,
            cart: viewControllers.cart
        )
    }
}
