//
//  DataBase.swift
//  Month5
//
//  Created by User on 29/3/23.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

final class DataBase {
    static let shared = DataBase()
    private let db = Firestore.firestore()
    
    private init() { }
    
    public func setTo(collection: String, document: String, withData data: [String: Any]) {
        db.collection(collection)
            .document(document)
            .setData(data) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document succesfully written!")
                }
            }
    }
    
    public func readFrom(collection: String, document: String) {
        let docRef = db.collection(collection).document(document)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }
    }
    
    public func deleteFrom(collection: String,document: String) {
        db.collection(collection).document(document).delete()
    }
}
