//
//  Product.swift
//  ShoeShock
//
//  Created by Jody Abney on 4/21/20.
//  Copyright © 2020 AbneyAnalytics. All rights reserved.
//

import Foundation

class Product {
    private(set) public var title: String
    private(set) public var price: String
    private(set) public var imageName: String
    private(set) public var manufacturerID: ValidManufacturers
    private(set) public var market: Market
    public var cartIndicator: Bool
    
    init(title: String, price: String, imageName: String, manufacturerID: ValidManufacturers, market: Market, cartIndicator: Bool) {
        self.title = title
        self.price = price
        self.imageName = imageName
        self.manufacturerID = manufacturerID
        self.market = market
        self.cartIndicator = cartIndicator
    }
    
    func updateCartIndicator(to cartIndicator: Bool) {
        self.cartIndicator = cartIndicator
    }
}

extension Product: Equatable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.title == rhs.title && lhs.price == rhs.price &&
        lhs.imageName == rhs.imageName && lhs.manufacturerID == rhs.manufacturerID &&
            lhs.market == rhs.market
    }
    
    
    
}
