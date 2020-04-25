//
//  CartViewController.swift
//  ShoeShock
//
//  Created by Jody Abney on 4/23/20.
//  Copyright © 2020 AbneyAnalytics. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var cartTotalLabel: UILabel!
    

    @IBOutlet weak var numberOfItemsLabel: UILabel!
    
    
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
    }
    
//MARK: - TableView Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.getCart().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as? CartTableViewCell {
            let cartItem = DataService.instance.getCart()[indexPath.row]
            cell.updateView(cartItem: cartItem!)
            
            cell.stepperButtonAction = {
                let quantity = Int(cell.quantityLabel.text!)!
                DataService.instance.changeItemQuantity(cartItem: cartItem!, newQuantity: quantity)
                self.updateView()
            }
            return cell
        } else {
            return CartTableViewCell()
        }
    }
    
    //MARK: - TODO: What do I need to do if quantity is set to zero? Should I
    //              remove the item from the cart and, if so, when does it get removed?
    //              Or, should I only remove the item by allowing the user to click
    //              remove button?
}
