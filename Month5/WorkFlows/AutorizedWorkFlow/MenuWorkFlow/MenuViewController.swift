//
//  MenuViewController.swift
//  Month5
//
//  Created by User on 15/3/23.
//

import UIKit

class MenuViewController: UIViewController, UICollectionViewDelegate {
    static let id = String(describing: MenuViewController.self)
    var networkAPI = MenuViewModel()
    private var viewModel = NetworkLayer.shared.cocktails
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var searchMenu: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuCollectionView.layer.cornerRadius = 20
        configure()
        fetchCarts()
        Task {
            do {
                try await NetworkLayer.shared.fetchCocktails()
            } catch {
                
            }
        }
    }
    
    private func fetchCarts() {
        Task {
            do {
                viewModel = try await networkAPI.fetchDrinks()
                DispatchQueue.main.async {
                    self.menuCollectionView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func configure() {
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        menuCollectionView.register(
            UINib(
                nibName: String(
                    describing: MenuCollectionViewCell.self
                ),
                bundle: nil),
            forCellWithReuseIdentifier: MenuCollectionViewCell.id
        )
    }
}

extension MenuViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.id, for: indexPath) as! MenuCollectionViewCell
        let model = viewModel.drinks![indexPath.row]
        cell.display(item: model)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.drinks!.count
    }
}

extension MenuViewController: UICollectionViewDelegateFlowLayout, LolDelegate {
    func vcLol() {
        let storyboard = UIStoryboard(name: "ProductDetailsWorkFlow", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProductDetailsViewController")
        navigationController!.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 220)
    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let storyboard = UIStoryboard(name: "ProductDetailsWorkFlow", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "ProductDetailsViewController")
//        navigationController!.pushViewController(vc, animated: true)
//    }
}
