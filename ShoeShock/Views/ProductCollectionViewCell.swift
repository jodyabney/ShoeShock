//
//  ProductCollectionViewCell.swift
//  ShoeShock
//
//  Created by Jody Abney on 4/21/20.
//  Copyright © 2020 AbneyAnalytics. All rights reserved.
//

import UIKit

//@IBDesignable
class ProductCollectionViewCell: UICollectionViewCell {
    
    
    var addToCartButtonAction: ( () -> () )?
    
    var detailsButtonAction: ( () -> () )?
    
    
    @IBOutlet weak var manufacturerLabel: UILabel!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var detailsButton: UIButton!
        
    
    @IBAction func addToCartTapped(_ sender: UIButton) {        
        addToCartButtonAction?()
    }
    
    
    @IBAction func detailsTapped(_ sender: UIButton) {
        detailsButtonAction?()
    }
    
    
    func updateView(for product: Product) {
        manufacturerLabel.text = product.manufacturerID.rawValue.uppercased()
        manufacturerLabel.textColor = .white
        productLabel.text = product.title.uppercased()
        productLabel.textColor = .white
        priceLabel.text = CurrencyStringFormatter.instance.format(string: product.price)
        priceLabel.textColor = .white
        imageView.image = UIImage(named: product.imageName)
        
        // set proper cartIndicator icon
        if product.cartIndicator == true {
            addToCartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            addToCartButton.setImage(UIImage(systemName: "heart"), for: .normal)

        }

        
        // set the background color
        let manufacturerBackgroundColor = DataService.instance.getManufacturers().first(where: {
            $0.id == product.manufacturerID } )!.color
        contentView.backgroundColor = manufacturerBackgroundColor
        
        // round the corners
        contentView.layer.cornerRadius = 25.0
        contentView.clipsToBounds = true
    }
    
    
    //MARK: - Methods for Custom Class to display on Interface Builder
    
//    override func prepareForInterfaceBuilder() {
//        super.prepareForInterfaceBuilder()
//        customizeView()
//    }
//
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Add action to perform when the Add to Cart button is tapped
        self.addToCartButton.addTarget(self, action: #selector(addToCartTapped(_:)), for: .touchUpInside)
        
        self.detailsButton.addTarget(self, action: #selector(detailsTapped(_:)), for: .touchUpInside)
    }
        
        //customizeView()
//    }
//
//    func customizeView() {
//
//        productRectangle.backgroundColor = .systemBlue
//        productRectangle.layer.cornerRadius = 5.0
//        productRectangle.clipsToBounds = true
//    }
}
