//
//  NetworkProtocols.swift
//  HammerTest
//

import Foundation
import PromiseKit

protocol MenuNetworkProtocol {
    func getMenu() -> Promise<[Food]>
}
