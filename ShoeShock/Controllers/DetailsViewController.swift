//
//  DetailsViewController.swift
//  ShoeShock
//
//  Created by Jody Abney on 4/23/20.
//  Copyright © 2020 AbneyAnalytics. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    private(set) public var product: Product?
    
    @IBOutlet weak var manufacturerLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateView()
    }
    
    func initProductDetail(for product: Product) {
        self.product = product
    }
    

    func updateView() {
        manufacturerLabel.text = product!.manufacturerID.rawValue
        titleLabel.text = product!.title
        priceLabel.text = product!.price
        productImageView.image = UIImage(named: product!.imageName)
        
        navigationItem.title = (product?.manufacturerID.rawValue)! + " " + product!.title
        // set view background based on product manufacturer
        let manufacturers = DataService.instance.getManufacturers()
        let color = manufacturers.first(where: { $0.id == product?.manufacturerID } )?.color
        view.backgroundColor = color
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}