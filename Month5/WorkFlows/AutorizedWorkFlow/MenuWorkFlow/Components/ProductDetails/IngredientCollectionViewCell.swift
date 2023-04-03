//
//  IngredientCollectionViewCell.swift
//  Month5
//
//  Created by User on 29/3/23.
//

import UIKit

class IngredientCollectionViewCell: UICollectionViewCell {
    static var idCV = String(describing: IngredientCollectionViewCell.self)
    
    @IBOutlet weak var ingredientImage: UIImageView!

    func display(item: Ingredients) {
        ingredientImage.image = UIImage(named: item.image)
    }
}
