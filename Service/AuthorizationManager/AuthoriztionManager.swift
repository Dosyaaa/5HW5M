//
//  AuthoriztionManager.swift
//  Month5
//
//  Created by User on 22/3/23.
//

import Foundation
import FirebaseAuth

class AuthorizationManager {
    private let auth = Auth.auth()
    private let provider = PhoneAuthProvider.provider()
    private var verificationID: String?
    
    /// Метод, для того чтобы отправлять номер телефона в Firebase
    /// - Parameters:
    ///   - phoneNumber: Номер теелфона
    ///   - completion: Получаем succes с verificationID
    func tryToSendSMSCode(phoneNumber: String, completion: @escaping (Result<Void, Error>) -> Void) {
        provider.verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
            guard let verificationID = verificationID, error == nil else {
                completion(.failure(error!))
                return
            }
            
            self.verificationID = verificationID
            completion(.success(()))
        }
    }
    
    
    /// Метод для верификации смс кода
    /// - Parameters:
    ///   - smsCode: на телефоне
    ///   - completion: result
    func tryToSignIn(smsCode: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let verificationID = verificationID else {
            fatalError()
        }
        
        let credential = provider.credential(withVerificationID: verificationID, verificationCode: smsCode)
        
        auth.signIn(with: credential) { [weak self] result, error in
            guard let self = self else { return }
            guard let _ = result, error == nil else {
                completion(.failure(error!))
                return
            }
            
            if self.auth.currentUser != nil {
                completion(.success(()))
            }
        }
    }
}
