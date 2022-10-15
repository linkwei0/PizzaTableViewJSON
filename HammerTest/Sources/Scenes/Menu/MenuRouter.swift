//
//  MenuRouter.swift
//  HammerTest
//

import Foundation

protocol MenuRouterProtocol: AnyObject {
    
}

class MenuRouter {
    weak var viewController: BaseViewController?
}

// MARK: - MenuRouterProtocol

extension MenuRouter: MenuRouterProtocol {
}
