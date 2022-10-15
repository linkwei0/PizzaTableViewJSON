//
//  Food.swift
//  HammerTest
//

import Foundation

struct Food: Codable {
    let id: Int
    let category: String
    let name: String
    let topping: [String]?
    let price: Int
    let rank: Int?
}

struct Category {
    let text: String
    var isSelected: Bool = false
}
