//
//  BasketViewController.swift
//  Month5
//
//  Created by User on 1/4/23.
//

import UIKit

class BasketViewController: UIViewController {
    
    static let id = String(describing: BasketViewController.self)
    private var viewModel = NetworkLayer.shared.cocktails
    @IBOutlet weak var basketTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTV()
    }
    var basket: Menu?
    var basketTV: [Menu] = []
    func configureTV() {
        basketTableView.delegate = self
        basketTableView.dataSource = self
        basketTableView.register(UINib(nibName: BasketViewController.id, bundle: nil), forCellReuseIdentifier: BasketViewController.id)
    }
}

extension BasketViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
}

extension BasketViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basketTV.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BasketViewController.id, for: indexPath) as! BasketTableViewCell
        let model = basketTV[indexPath.row]
        cell.display(item: model)
        cell.delegate2 = self
        return cell
    }
}

extension BasketViewController: ButtonCellDelegate {
    func basketButton(item: Menu) {
            guard let secondVC = UIStoryboard(name: "BasketWorkFlow",
                                              bundle: nil
            )
                .instantiateViewController(
                    withIdentifier: BasketViewController.id
                ) as? BasketViewController
            else {
                return
            }
            secondVC.basket = item
            navigationController?.pushViewController(secondVC, animated: true)
    }
}
