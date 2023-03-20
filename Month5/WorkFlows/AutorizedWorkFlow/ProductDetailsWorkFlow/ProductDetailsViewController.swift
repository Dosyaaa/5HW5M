//
//  ProductDetailsViewController.swift
//  Month5
//
//  Created by User on 18/3/23.
//

import UIKit
protocol LolDelegate {
    func vcLol()
}
class ProductDetailsViewController: UIViewController {

    
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var strangersView: UILabel!
    @IBOutlet weak var additionsView: UIView!
    @IBOutlet weak var cocktailsImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        strangersView.layer.cornerRadius = 30 / 2
        likeImage.layer.borderWidth = 2
        likeImage.layer.borderColor = UIColor.orange.cgColor
        likeImage.layer.cornerRadius = 28 / 2
        additionsView.layer.borderWidth = 2
        additionsView.layer.borderColor = UIColor.orange.cgColor
    }
}
