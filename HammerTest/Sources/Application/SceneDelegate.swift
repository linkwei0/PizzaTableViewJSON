//
//  SceneDelegate.swift
//  HammerTest
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let viewController = MenuModuleBuidler.build()
        
        let submodules = (
            menu: viewController,
            contact: BaseViewController(),
            profile: BaseViewController(),
            cart: BaseViewController()
        )
        let tabBarController = TabBarModuleBuilder.build(submodules: submodules)
        window.rootViewController = tabBarController
        self.window = window
        window.makeKeyAndVisible()
    }
}
