//
//  AppDependency.swift
//  HammerTest
//

import Foundation

protocol HasMenuService {
    var menuService: MenuNetworkProtocol { get }
}

class AppDependency {
    private let networkServce: NetworkService
    
    init() {
        self.networkServce = NetworkService()
    }
}

// MARK: - HasMenuService

extension AppDependency: HasMenuService {
    var menuService: MenuNetworkProtocol {
        networkServce
    }
}
