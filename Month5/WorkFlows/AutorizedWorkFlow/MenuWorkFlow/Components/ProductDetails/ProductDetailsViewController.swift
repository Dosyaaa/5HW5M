//
//  ProductDetailsViewController.swift
//  Month5
//
//  Created by User on 18/3/23.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    static let reuseID = String(describing: ProductDetailsViewController.self)

    
    @IBOutlet weak var likeImage: UIImageView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
            likeImage.addGestureRecognizer(tap)
            likeImage.isUserInteractionEnabled = true
        }
    }
    @IBOutlet weak var strangersView: UILabel!
    @IBOutlet weak var additionsView: UIView!
    @IBOutlet weak var cocktailsImage: UIImageView!
    @IBOutlet weak var ingredientsCV: UICollectionView!
    @IBOutlet weak var counterLabel: UILabel!
    
    @IBAction func basketButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "BasketWorkFlow", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: BasketViewController.id)
        self.navigationController!.pushViewController(vc, animated: true)
    }
    @IBAction
    private func increaseTapped() {
        delegate?.increaseTap()
    }
    
    @IBAction
    private func decreasedapped() {
        delegate?.decreaseTap()
    }
    
    @objc
    func imageTapped() {
        print("tapped")
        likeImage.image = UIImage(named: "heart.fill")
        likeImage.tintColor = .red
    }
    weak var delegate2: ButtonCellDelegate?
    weak var delegate: CounterCellDelegate?
    
    let ingredients: [Ingredients] = [Ingredients(image: "1"),Ingredients(image: "2"),Ingredients(image: "3"),Ingredients(image: "4")]
    var product: Menu?
    private var counter = Counter(counter: 1)
    
    override func viewDidLoad() {
        configureCV()
        
    }
    
    func counterDisplay(item: Counter) {
        counterLabel.text = "\(item.counter)"
    }
    
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
    
    
    
    private func configureCV() {
        ingredientsCV.delegate = self
        ingredientsCV.dataSource = self
        ingredientsCV.register(UINib(nibName: IngredientCollectionViewCell.idCV, bundle: nil),forCellWithReuseIdentifier: IngredientCollectionViewCell.idCV)
    }
    
    private func handleCounter(with type: CounterType) {
        switch type {
        case .plus:
            counter.counter += 1
        case .minus:
            counter.counter -= 1
        }
        StorageManager.shared.saveCounter(with: counter.counter)
        ingredientsCV.reloadData()
    }
}

extension ProductDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IngredientCollectionViewCell.idCV, for: indexPath) as! IngredientCollectionViewCell
        let model = ingredients[indexPath.row]
        cell.display(item: model)
        delegate = self
        counterDisplay(item: counter)
        return cell
    }
    
    
}

extension ProductDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
}

extension ProductDetailsViewController: CounterCellDelegate {
    func increaseTap() {
        print("Increase")
        handleCounter(with: .plus)
    }
    func decreaseTap() {
        print("Decrease")
        handleCounter(with: .minus)
    }
}
