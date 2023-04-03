//
//  StorageManager.swift
//  Month5
//
//  Created by User on 29/3/23.
//

import Foundation

final class StorageManager {
    static let shared = StorageManager()
    
    private init() { }
    
    func saveCounter(with number: Int) {
        UserDefaults.standard.set(number, forKey: "counter")
    }
}
