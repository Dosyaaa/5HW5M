//
//  SplashViewController.swift
//  Month5
//
//  Created by User on 1/4/23.
//

import UIKit

class SplashViewController: UIViewController {

    private let keychain = KeyChainManager.shared
    private let encoder = JSONDecoder()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970

        if let data = keychain.read(with: SplashConstants.Keychain.service, SplashConstants.Keychain.account),
           let date = try? decoder.decode(Date.self, from: data),
           date > Date() {
            let vc = storyboard!.instantiateViewController(withIdentifier: MenuViewController.id)
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
            
        } else {
            let storyboard = UIStoryboard(name: "ProfileWorkFlow", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: ProfileViewController.id)
            self.navigationController!.pushViewController(vc, animated: true)
        }
    }
}
