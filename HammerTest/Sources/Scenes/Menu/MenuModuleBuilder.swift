//
//  MenuModuleBuilder.swift
//  HammerTest
//

import UIKit

class MenuModuleBuidler {
    static func build() -> BaseViewController {
        let appDependencies = AppDependency()
        let interactor = MenuInteractor(dependencies: appDependencies)
        let router = MenuRouter()
        let presenter = MenuPresenter(router: router, interactor: interactor)
        let viewController = MenuViewController(presenter: presenter)
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
    
    private func buildTabBar() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = []
        return tabBarController
    }
}
