//
//  VerificationViewController.swift
//  Month5
//
//  Created by User on 3/4/23.
//

import UIKit

class VerificationViewController: UIViewController {

    static let id = String(describing: VerificationViewController.self)
    @IBOutlet private weak var verificationTetxtField: UITextField!
    
    private let authApi = AuthorizationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction private func sendVerificationCodeTap() {
        guard let vCode = verificationTetxtField.text, !vCode.isEmpty else {
            return
        }
        authApi.tryToSignIn(smsCode: vCode) { result in
            if case .success = result {
                self.present(SplashViewController(), animated: true)
            } else {
                
            }
        }
    }

    
}
