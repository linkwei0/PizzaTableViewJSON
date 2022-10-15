//
//  NetworkService+Menu.swift
//  HammerTest
//

import Foundation
import PromiseKit

extension NetworkService: MenuNetworkProtocol {
    func getMenu() -> Promise<[Food]> {
        return request(method: .get, url: URLFactory.Menu.menu())
    }
}
