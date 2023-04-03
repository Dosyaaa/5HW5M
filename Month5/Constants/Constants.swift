//
//  Constants.swift
//  Month5
//
//  Created by User on 20/3/23.
//

import Foundation

enum Constants {
    static let baseURL = URL(string: "www.thecocktaildb.com/api/json/v1/1/search.php")!
}

enum HTTPRequest {
    case POST,PUT,DELETE
}

enum CounterType {
    case plus, minus
}

protocol CounterCellDelegate: AnyObject {
    func increaseTap()
    func decreaseTap()
}

enum SplashConstants {
    enum Keychain {
        static let service = "PhoneAuth"
        static let account = "phoneSign"
    }
}
