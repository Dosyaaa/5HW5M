//
//  MenuViewModel.swift
//  Month5
//
//  Created by User on 20/3/23.
//

import Foundation

class MenuViewModel {
    
    private let networkService = NetworkService.shared
    
    var drinks: [Menu] = []
    
    func fetchDrinks() async throws -> Menus {
        return try await NetworkLayer.shared.fetchCocktails()
    }
}
