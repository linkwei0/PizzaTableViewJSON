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
    
    static let mockFood =
    [
        Food(id: 0, category: MockCategory.pizza.rawValue, name: "Пицца 4 сыра", topping: nil, price: 249, rank: nil),
        Food(id: 1, category: MockCategory.pizza.rawValue, name: "Пицца ветчина и грибы",
             topping: nil, price: 199, rank: nil),
        Food(id: 2, category: MockCategory.pizza.rawValue, name: "Пицца пеперони", topping: nil, price: 249, rank: nil),
        Food(id: 3, category: MockCategory.pizza.rawValue, name: "Пицца фреш", topping: nil, price: 149, rank: nil),
        Food(id: 4, category: MockCategory.pizza.rawValue, name: "Пицца 8 сыров", topping: nil, price: 150, rank: nil),
        Food(id: 5, category: MockCategory.salad.rawValue, name: "Салат Греческий", topping: nil, price: 99, rank: nil),
        Food(id: 6, category: MockCategory.salad.rawValue, name: "Салат Цезарь", topping: nil, price: 129, rank: nil),
        Food(id: 7, category: MockCategory.salad.rawValue, name: "Салат Греческий", topping: nil, price: 99, rank: nil),
    ]
    
    enum MockCategory: String {
        case pizza = "Пицца", salad = "Салат"
    }
}

struct Category {
    let text: String
    var isSelected: Bool = false
}
