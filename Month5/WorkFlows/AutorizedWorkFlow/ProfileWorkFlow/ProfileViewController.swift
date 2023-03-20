//
//  ProfileViewController.swift
//  Month5
//
//  Created by User on 15/3/23.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBAction private func exitButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MenuWorkFlow", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MenuViewController")
        navigationController!.pushViewController(vc, animated: true)
    }
    @IBAction private func registerButton() {
        
    }
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var dataOfBirthTextField: UITextField!
    @IBOutlet private weak var addressTextField: UITextField!
}


