//
//  TabBarModuleBuilder.swift
//  HammerTest
//

import UIKit

class TabBarModuleBuilder {
    static func build(submodules: TabBarRouter.Submodules) -> UITabBarController {
        let tabs = TabBarRouter.tabs(submodules)
        let tabBarController = TabBarController(tabs: tabs)
        return tabBarController
    }
}
