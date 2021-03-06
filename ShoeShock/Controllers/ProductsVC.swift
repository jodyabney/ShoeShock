//
//  ProductsViewController.swift
//  ShoeShock
//
//  Created by Jody Abney on 4/21/20.
//  Copyright © 2020 AbneyAnalytics. All rights reserved.
//

import UIKit

class ProductsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var manufacturersCollectionView: UICollectionView!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var cartBadge: UILabel!
    
    // which Manufacturer has been selected - default to All
    var selectedManufacturerID: ValidManufacturers = .all
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manufacturersCollectionView.delegate = self
        manufacturersCollectionView.dataSource = self
        
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        
        updateCartIcon()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        updateCartIcon()
        selectedManufacturerID = .all
        manufacturersCollectionView.reloadData()
        productsCollectionView.reloadData()
    }
    
    
    func updateCartIcon() {
        let cartCount = DataService.instance.getCartItemCount()
        if cartCount > 0 {
            cartButton.setImage(UIImage(systemName: "cart.fill"), for: .normal)
            cartBadge.isHidden = false
            cartBadge.text = String(cartCount)
        } else {
            cartButton.setImage(UIImage(systemName: "cart"), for: .normal)
            cartBadge.isHidden = true
        }
    }
    
    //MARK: - Collection View Data Source Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case manufacturersCollectionView:
            return DataService.instance.getManufacturerNames().count
        case productsCollectionView:
            return DataService.instance.getProducts(for: selectedManufacturerID).count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
            
        case manufacturersCollectionView:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ManufacturerCell", for: indexPath) as? ManufacturersCollectionViewCell {
                let manufacturer = DataService.instance.getManufacturers()[indexPath.row]
                cell.updateView(manufacturer: manufacturer)
                //cell.manufacturerNameLabel.adjustsFontSizeToFitWidth = true
                cell.sizeToFit()
                if manufacturer.id == selectedManufacturerID {
                    cell.manufacturerNameLabel.textColor = .red
                } else {
                    cell.manufacturerNameLabel.textColor = .label
                }
                return cell
            } else {
                return ManufacturersCollectionViewCell()
            }
            
        case productsCollectionView:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCollectionViewCell {
                let product = DataService.instance.getProducts(for: selectedManufacturerID)[indexPath.row]
                cell.updateView(for: product)
                cell.sizeToFit()
                
                // the code that will be executed when user taps on the addToCart button
                cell.addToCartButtonAction = {
                    let cartItem = CartItem(product: product, quantity: 1)
                    if cell.addToCartButton.imageView?.image == UIImage(systemName: "heart") {
                        DataService.instance.addCartItem(cartItem: cartItem)
                        
                        // Set the addToCartButton image to depict the item is now in the cart
                        // Could not use the ProductCollectionViewCell.update() function without
                        // reloading the the cell data using reloaddata(at:) function. If I used
                        // this function, it caused a strange screen behavior where the next cell
                        // partially and momentarily slid behind the current cell in the collection
                        // view
                        cell.addToCartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                    } else {
                        DataService.instance.removeCartItem(cartItem: cartItem)
                        cell.addToCartButton.setImage(UIImage(systemName: "heart"), for: .normal)
                    }
                    self.updateCartIcon()
                }
                
                cell.detailsButtonAction = {
                    DataService.instance.setProductForDetailVC(product: product)
                }
                
                // let the cell update itself
                cell.updateView(for: product)
                cell.sizeToFit()
                return cell
            } else {
                return ProductCollectionViewCell()
            }
            
        default:
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView {
            
        case manufacturersCollectionView:
            selectedManufacturerID = DataService.instance.getManufacturers()[indexPath.row].id
            manufacturersCollectionView.reloadData()
            productsCollectionView.reloadData()
            
        default:
            return
        }
        
    }
    
    
    //MARK: - Segue Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToCartVC" {
            // set up back button to only display the arrow (no title)
            let barButton = UIBarButtonItem()
            barButton.title = ""
            navigationItem.backBarButtonItem = barButton
            
        } else if segue.identifier == "SegueToDetailsVC" {
            // set up back button to only display the arrow (no title)
            let barButton = UIBarButtonItem()
            barButton.title = ""
            navigationItem.backBarButtonItem = barButton
        }
    }
    
}

