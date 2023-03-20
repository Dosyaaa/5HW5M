//
//  NetworkService.swift
//  Month5
//
//  Created by User on 15/3/23.
//

import Foundation

final class NetworkService {
    
    static let shared = NetworkService()
    
    private init () { }
    
    func fetchDrinks() async throws -> [Menu] {
        let request = URLRequest(url: Constants.baseURL)
        let (data, _) = try await URLSession.shared.data(for: request)
        let model: Menus = try NetworkHelpers.decode(with: data)
        return model.drinks ?? []
    }
}
