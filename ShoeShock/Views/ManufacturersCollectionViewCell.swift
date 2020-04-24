//
//  ManufacturersCollectionViewCell.swift
//  ShoeShock
//
//  Created by Jody Abney on 4/21/20.
//  Copyright © 2020 AbneyAnalytics. All rights reserved.
//

import UIKit

class ManufacturersCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var manufacturerNameLabel: UILabel!
    
    func updateView(manufacturer: Manufacturer) {
        manufacturerNameLabel.text = manufacturer.id.rawValue
    }
}
