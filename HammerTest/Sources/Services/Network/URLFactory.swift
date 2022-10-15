//
//  URLFactory.swift
//  HammerTest
//

import Foundation

struct URLFactory {
    private static let baseURL = "https://private-anon-eb702227f4-pizzaapp.apiary-mock.com/restaurants/restaurantId"
    
    struct Menu {
        static let foodMenu = baseURL + "/menu"
        static func menu() -> String {
            return foodMenu
        }
    }
}
