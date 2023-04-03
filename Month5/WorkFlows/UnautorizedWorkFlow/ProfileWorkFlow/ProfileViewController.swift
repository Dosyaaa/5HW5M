//
//  ProfileViewController.swift
//  Month5
//
//  Created by User on 15/3/23.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    static let id = String(describing: ProfileViewController.self)
    private let authApi = AuthorizationManager()
    
    @IBAction private func exitButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MenuWorkFlow", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: MenuViewController.id)
        self.navigationController!.pushViewController(vc, animated: true)
    }
    @IBAction private func registerButton() {
        guard let phone = emailTextField.text, !phone.isEmpty else {
            return
        }
        authApi.tryToSendSMSCode(phoneNumber: phone) { result in
            if case .success = result {
                let alert = UIAlertController(
                    title: "Succes",
                    message: "SMS code sended",
                    preferredStyle: .alert
                )
                let exitAction = UIAlertAction(title: "Ok", style: .destructive) { action in
                    let storyboard = UIStoryboard(name: "VerificationWorkFlow", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: VerificationViewController.id)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                alert.addAction(exitAction)
                self.present(alert, animated: true)
            } else {
                let alert = UIAlertController(
                    title: "Error",
                    message: "SMS code failed",
                    preferredStyle: .alert
                )
                alert.addAction(.init(title: "Okay", style: .cancel))
                self.present(alert, animated: true)
            }
        }
    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.navigationController?.isNavigationBarHidden = true
//    }
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var dataOfBirthTextField: UITextField!
    @IBOutlet private weak var addressTextField: UITextField!
}


