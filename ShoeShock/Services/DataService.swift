//
//  DataService.swift
//  ShoeShock
//
//  Created by Jody Abney on 4/21/20.
//  Copyright © 2020 AbneyAnalytics. All rights reserved.
//

import Foundation

class DataService {
    
    static let instance = DataService()
    
    //MARK: - Private datamarts
    
    private var productForDetailsVC: Product?
    
    private let manufacturers: [Manufacturer] = [
        Manufacturer(id: .all, color: .clear),
        Manufacturer(id: .nike, color: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)),
        Manufacturer(id: .addidas, color: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)),
        Manufacturer(id: .jordan, color: #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)),
        Manufacturer(id: .puma, color: #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)),
        Manufacturer(id: .reebok, color: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
    ]
    
    private var products: [Product] = [
        // Reeboks
        Product(title: "Aztrek", price: "80.00", imageName: "reebok_aztrek.png",
                manufacturerID: .reebok, market: .shoes, cartIndicator: false),
        Product(title: "BB4600", price: "70.00", imageName: "reebok_bb4600.png",
                manufacturerID: .reebok, market: .shoes, cartIndicator: false),
        Product(title: "Classic Leather", price: "75.00", imageName: "reebok_classic_leather.png",
                manufacturerID: .reebok, market: .shoes, cartIndicator: false),
        Product(title: "Club C", price: "69.99", imageName: "reebok_club_c.png",
                manufacturerID: .reebok, market: .shoes, cartIndicator: false),
        Product(title: "Question Mid", price: "75.00", imageName: "reebok_question_mid.png",
                manufacturerID: .reebok, market: .shoes, cartIndicator: false),
        // Addidas
        Product(title: "Originals Hardcourt", price: "99", imageName: "adidas_originals_hardcourt.png",
                manufacturerID: .addidas, market: .shoes, cartIndicator: false),
        // Jordan
        Product(title: "6 Rings", price: "99", imageName: "jordan_6_rings.png",
                manufacturerID: .jordan, market: .shoes, cartIndicator: false),
        // Nike
        Product(title: "Air Force 1 Low", price: "99", imageName: "nike_air_force_1_low.png",
                manufacturerID: .nike, market: .shoes, cartIndicator: false),
        // Puma
        Product(title: "Clyde Hacked", price: "99", imageName: "puma_clyde_hacked.png",
                manufacturerID: .puma, market: .shoes, cartIndicator: false)
    ]
    
    private let categories: [Category] = [
        Category(name: "New", associatedProducts: nil),
        Category(name: "Featured", associatedProducts: nil),
        Category(name: "Upcoming", associatedProducts: nil)
    ]
    
    private var shoppingCart: [CartItem] = []
    
    
    //MARK: - Public datamarts
    
    public func getProductForDetailVC() -> Product {
        return productForDetailsVC!
    }
    
    public func setProductForDetailVC(product: Product) {
        productForDetailsVC = product
    }
    
    public func getManufacturers() -> [Manufacturer] {
        return manufacturers
    }
    
    public func getManufacturerNames() -> [String] {
        var manufacturerNames = [String]()
        let manufacturers = getManufacturers()
        for m in manufacturers {
            manufacturerNames.append(m.id.rawValue)
        }
        return manufacturerNames
    }
    
    private func getAllProducts() -> [Product] {
        return products
    }
    
    public func getProducts(for manufacturerID: ValidManufacturers) -> [Product] {
        if manufacturerID == ValidManufacturers.all {
            return products
        } else {
            let manufacturerProducts = products.all(where: { $0.manufacturerID == manufacturerID } )
            return manufacturerProducts
        }
    }
    
    //MARK: - Cart Methods
    
    func getCart() -> [CartItem?] {
        return shoppingCart
    }
    
    func clearCart() {
        for item in shoppingCart {
            removeCartItem(cartItem: item)
        }
    }
    
    func addCartItem(cartItem: CartItem) {
        if cartItem.product.cartIndicator == true {
            let item = shoppingCart.first(where: { $0.product == cartItem.product } )!
            changeItemQuantity(cartItem: item, newQuantity: item.quantity + 1)
        } else {
            let cartItem = CartItem(product: cartItem.product, quantity: 1)
            shoppingCart.append(cartItem)
            let productIndex = products.firstIndex(of: cartItem.product)!
            products[productIndex].cartIndicator = true
        }
    }
    
    func changeItemQuantity(cartItem: CartItem, newQuantity: Int) {
        if let itemIndex = shoppingCart.firstIndex(where: { $0.product == cartItem.product } ) {
            if newQuantity > 0 {
                shoppingCart[itemIndex].quantity = newQuantity
            } else {
                removeCartItem(cartItem: cartItem)
            }
        }
    }
    
    func removeCartItem(cartItem: CartItem) {
        let itemPosition = shoppingCart.firstIndex(where: { $0.product == cartItem.product } )!
        shoppingCart.remove(at: itemPosition)
        let productIndex = products.firstIndex(of: cartItem.product)!
        products[productIndex].cartIndicator = false
    }
    
    func getCartTotal() -> Double {
        guard shoppingCart.count > 0 else {
            return 0.00
        }
        var subtotal: Double = 0.00
        for item in shoppingCart {
            subtotal += Double(item.quantity) * Double(item.product.price)!
        }
        return subtotal
    }
    
    func getCartItemCount() -> Int {
        guard shoppingCart.count > 0 else {
            return 0
        }
        var itemCount = 0
        for item in shoppingCart {
            itemCount += item.quantity
        }
        return itemCount
    }
}
