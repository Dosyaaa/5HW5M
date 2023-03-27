//
//  NetworkHelpers.swift
//  Month5
//
//  Created by User on 15/3/23.
//

import Foundation

struct NetworkHelpers {
    static func decode<T: Decodable>(with data: Data) -> T {
        try! JSONDecoder().decode(T.self, from: data)
    }
}

final class NetworkLayer {
    static let shared = NetworkLayer()
    var cocktails = Menus(drinks: [])
    func fetchCocktails() async throws -> Menus {
        var cocktails1 = cocktails
        for value in UnicodeScalar("a").value...UnicodeScalar("z").value {
            guard let unicodeLetter = UnicodeScalar(value),
            case let letter = String(unicodeLetter) else {
                fatalError("This unicode scalar is not valid")
            }
            let drinks = try await fetchDataByLetter(letter)
            cocktails1.drinks?.append(contentsOf: drinks.drinks ?? [])
            print("Cocktails model for letter: \(letter) is \(drinks)")
        }
        return cocktails1
    }
    private func fetchDataByLetter(_ char: String) async throws -> Menus {
        var urlComponents  = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "www.thecocktaildb.com"
        urlComponents.path = "/api/json/v1/1/search.php"
        urlComponents.queryItems = [.init(name: "f", value: char)]

        guard let url = urlComponents.url else {
            fatalError("URL NOT CORRECT")
        }

        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
        return try NetworkHelpers.decode(with: data)
    }
    
    func searchProduct(by word: String) async throws -> Menus {
        let url = Constants.baseURL.appendingPathComponent("search")
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [.init(name: "q", value: word)]
        guard let url = urlComponents?.url else {
            return try Menus(from: [] as! Decoder)
        }
        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
        return try! NetworkHelpers.decode(with: data)
    }
}
