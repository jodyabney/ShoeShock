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
        
        //MARK: - TODO: Handle navigation back to ProductsVC instead of CartVC
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
