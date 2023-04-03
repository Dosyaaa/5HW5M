//
//  BasketTableViewCell.swift
//  Month5
//
//  Created by User on 1/4/23.
//

import UIKit
protocol ButtonCellDelegate: AnyObject{
    func basketButton(item: Menu)
}

class BasketTableViewCell: UITableViewCell {
    static let id = String(describing: BasketTableViewCell.self)
    @IBOutlet weak var basketImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    weak var delegate2: ButtonCellDelegate?
    func display(item: Menu) {
        basketImage.image = UIImage(named: item.strDrinkThumb)
        nameLabel.text = item.strDrink
    }
}
