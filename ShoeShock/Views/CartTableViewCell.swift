//
//  CartTableViewCell.swift
//  ShoeShock
//
//  Created by Jody Abney on 4/24/20.
//  Copyright © 2020 AbneyAnalytics. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    var stepperButtonAction: ( () -> () )?
    
    @IBOutlet weak var viewForProductImage: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    @IBOutlet weak var stepper: UIStepper!
    

    @IBOutlet weak var quantityLabel: UILabel!
    
    
    let currencyFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .currency
        nf.currencySymbol = Locale.current.currencySymbol
        nf.currencyDecimalSeparator = Locale.current.decimalSeparator
        return nf
    }()

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Add action to perform when the Add to Cart button is tapped
        self.stepper.addTarget(self, action: #selector(quantityChangeTapped(_:)), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func quantityChangeTapped(_ sender: UIStepper) {
        quantityLabel.text = String(Int(sender.value))
        stepperButtonAction?()
    }
    
    
    func updateView(cartItem: CartItem) {
        viewForProductImage.layer.cornerRadius = 15.0
        viewForProductImage.clipsToBounds = true
        productImage.image = UIImage(named: cartItem.product.imageName)
        titleLabel.text = cartItem.product.title.uppercased()
        let price = Double(cartItem.product.price)!
        priceLabel.text = currencyFormatter.string(from: NSNumber(value: price))
        quantityLabel.text = String(cartItem.quantity)
        stepper.value = Double(cartItem.quantity)
    }

}
