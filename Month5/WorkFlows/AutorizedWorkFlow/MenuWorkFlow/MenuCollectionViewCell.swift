//
//  MenuCollectionViewCell.swift
//  Month5
//
//  Created by User on 15/3/23.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell{
    static let id = String(describing: MenuCollectionViewCell.self)
    @IBOutlet weak var imageMenu: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBAction func byNowButton(_ sender: Any) {
        
    }

    func display(item: Menu) {
        nameLabel.text = item.strDrink
        imageMenu.getImage(item.strDrinkThumb)
    }
}
