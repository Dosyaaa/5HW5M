//
//  ProductDetailsViewController.swift
//  Month5
//
//  Created by User on 18/3/23.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    static let reuseID = String(describing: ProductDetailsViewController.self)
    
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var strangersView: UILabel!
    @IBOutlet weak var additionsView: UIView!
    @IBOutlet weak var cocktailsImage: UIImageView!
    
    var product: Menu?
    
    func display(item: Menu) {
        cocktailsImage.image = UIImage(named: item.strDrinkThumb)
    }
    override func viewWillAppear(_ animated: Bool) {
        guard let product = product else { return }
        configure(from: product)
    }
    
    public func configure(from model: Menu) {
        cocktailsImage.getImage(model.strDrinkThumb)
    }
}
