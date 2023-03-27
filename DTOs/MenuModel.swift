//
//  MenuModel.swift
//  Month5
//
//  Created by User on 15/3/23.
//

import Foundation

struct Menu: Codable {
    let strDrink: String
    let strDrinkThumb: String
}

struct Menus: Codable {
    var drinks: [Menu]?
}

