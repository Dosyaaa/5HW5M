//
//  IngredientsCollectionViewCell.swift
//  Month5
//
//  Created by User on 29/3/23.
//

import UIKit

class IngredientsCollectionViewCell: UICollectionViewCell {
    static let idCV = String(describing: IngredientsCollectionViewCell.self)
    
    @IBOutlet weak var ingredientImage: UIImageView!
    
    func display(item: Ingredients) {
        ingredientImage.image = UIImage(named: item.image)
    }
}
