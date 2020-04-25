//
//  CartViewController.swift
//  ShoeShock
//
//  Created by Jody Abney on 4/23/20.
//  Copyright © 2020 AbneyAnalytics. All rights reserved.
//

import UIKit

class CartVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cartTotalLabel: UILabel!
    @IBOutlet weak var numberOfItemsLabel: UILabel!
    @IBOutlet weak var purchaseButton: RoundedButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        updateView()
    }
    
    
    func updateView() {
        // format and set cart total
        let total = DataService.instance.getCartTotal()
        cartTotalLabel.text = CurrencyStringFormatter.instance.format(double: total)
        
        // get and set total quantity in cart
        let itemCount = DataService.instance.getCartItemCount()
        if itemCount == 1 {
            numberOfItemsLabel.text = "Total \(itemCount) item"
        } else {
            numberOfItemsLabel.text = "Total \(itemCount) items"
        }
        
        // handle button based on cart contents
        if itemCount == 0 {
            purchaseButton.isEnabled = false
            purchaseButton.backgroundColor = #colorLiteral(red: 0.9781171679, green: 0.2369823754, blue: 0.3966103494, alpha: 0.5)
        } else {
            purchaseButton.isEnabled = true
            purchaseButton.backgroundColor = #colorLiteral(red: 0.9781171679, green: 0.2369823754, blue: 0.3966103494, alpha: 1)
        }
        
        
    }
    
    //MARK: - TableView Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.getCart().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as? CartTableViewCell {
            let cartItem = DataService.instance.getCart()[indexPath.row]

            cell.stepperButtonAction = {
                let quantity = Int(cell.quantityLabel.text!)!
                DataService.instance.changeItemQuantity(cartItem: cartItem!, newQuantity: quantity)
                
                if quantity > 0 {
                    self.updateView()
                } else {
                    tableView.reloadData()
                    self.updateView()
                }
            }
            cell.updateView(cartItem: cartItem!)
            
            return cell
        } else {
            return CartTableViewCell()
        }
    }
}
