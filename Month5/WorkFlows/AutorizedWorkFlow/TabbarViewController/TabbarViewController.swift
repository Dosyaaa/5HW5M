//
//  TabbarViewController.swift
//  Month5
//
//  Created by User on 2/4/23.
//

import UIKit

class TabbarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let item2 = UIStoryboard(name: "MenuWorkFlow", bundle: nil).instantiateViewController(withIdentifier: MenuViewController.id)
        let item1 = MenuViewController()
        let icon1 = UITabBarItem(
            title: "Title",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )
        let icon2 = UITabBarItem(
            title: "Title2",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )
        item1.tabBarItem = icon1
//        item2.tabBarItem = icon2
        let controllers = [item1]
        self.viewControllers = controllers
    }
}
