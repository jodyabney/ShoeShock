//
//  PurchaseViewViewController.swift
//  ShoeShock
//
//  Created by Jody Abney on 4/24/20.
//  Copyright © 2020 AbneyAnalytics. All rights reserved.
//

import UIKit

class PurchaseVC: UIViewController {

    @IBOutlet weak var purchaseConfirmationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let poNum = Int.random(in: 10000...99999)
        
        purchaseConfirmationLabel.text = "Congratulations!\n\nYour order (\(poNum)) has been submitted. "
    }
    

    @IBAction func returnToShopTapped(_ sender: UIButton) {
        
        DataService.instance.clearCart()
        self.dismiss(animated: true, completion: nil)
        navigationController?.popToRootViewController(animated: true)
    }
}
