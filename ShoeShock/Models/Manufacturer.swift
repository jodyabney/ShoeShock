//
//  Manufacturer.swift
//  ShoeShock
//
//  Created by Jody Abney on 4/22/20.
//  Copyright © 2020 AbneyAnalytics. All rights reserved.
//

import UIKit

class Manufacturer {
    var id: ValidManufacturers
    var color: UIColor
    
    init(id: ValidManufacturers, color: UIColor) {
        self.id = id
        self.color = color
    }
}
