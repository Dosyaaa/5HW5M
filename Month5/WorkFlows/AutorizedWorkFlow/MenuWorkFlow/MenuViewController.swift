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
    private var isLoading = false
    private var viewModel = NetworkLayer.shared.cocktails
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var searchMenu: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        menuCollectionView.layer.cornerRadius = 20
        configure()
        fetchMenu()
    }
    
    private func fetchMenu() {
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
    
    private func openDetailedCocktails(item: Menu) {
        guard let secondVC = UIStoryboard(name: "ProductDetailsWorkFlow",
                                          bundle: nil
        )
            .instantiateViewController(
                withIdentifier: "ProductDetailsViewController"
            ) as? ProductDetailsViewController
        else {
            return
        }
        secondVC.product = item
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
    private func searchProduct(by word: String) {
        isLoading = true
        Task {
            do {
                let model = try await NetworkLayer.shared.searchProduct(by: word)
                isLoading = false
                NetworkLayer.shared.cocktails = model
                DispatchQueue.main.async {
                    self.menuCollectionView.reloadData()
                }
            } catch {
                showError(with: error)
            }
        }
    }
    
    private func showError(with message: Error) {
        let alert = UIAlertController(
            title: "Error",
            message: message.localizedDescription,
            preferredStyle: .alert
        )
        alert.addAction(.init(title: "Okay", style: .cancel))
        present(alert, animated: true)
    }
}

extension MenuViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MenuCollectionViewCell.id,
                                                      for: indexPath
        ) as! MenuCollectionViewCell
        let model = viewModel.drinks![indexPath.row]
        cell.display(item: model)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.drinks!.count
    }
}

extension MenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 100, height: 220)
    }
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard let cell = collectionView.cellForItem(
            at: indexPath
        ) as? MenuCollectionViewCell else { return }
        let item = viewModel.drinks![indexPath.row]
        openDetailedCocktails(item: item)
    }
}

extension MenuViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !isLoading {
            searchProduct(by: searchText)
        }
    }
}
