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
        // Nike
        Product(title: "Air Force 1 Low", price: "90.00", imageName: "nike_air_force_1_low.png",
                manufacturerID: .nike, market: .shoes, cartIndicator: false, description: "Product #: 24300657\nAn Absolute Essential\nThe Nike Air Force 1 Low is inarguably one of the most essential sneakers of all time."),
        Product(title: "Air Max 2090", price: "150.00", imageName: "nike_air_max_2090.png",
                manufacturerID: .nike, market: .shoes, cartIndicator: false, description: ""),
        Product(title: "Air Max Plus", price: "170.00", imageName: "nike_air_max_plus.png",
                manufacturerID: .nike, market: .shoes, cartIndicator: false, description: "Product #: J2029001\nMaking Waves\nThe Men’s Nike Air Max Plus is a certified icon of the Nike Air Max family. First released in 1998, the Air Max Plus was instantly notable for its then-new Tuned Air technology as well as the eye-catching design."),
        Product(title: "Air Little Posite One", price: "180.00", imageName: "nike_little_posite_one.png",
                manufacturerID: .nike, market: .shoes, cartIndicator: false, description: "Product #: 44791011\nFuturistic Foamposite Technology for Kids\nThe Nike Little Posite One is a kids’ shoe modeled after the Nike Air Foamposite One, which is Penny Hardaway’s signature model. This basketball sneaker has a Foamposite upper for durable performance and a futuristic, trendy appearance."),
        Product(title: "Air More Uptempo '96", price: "160.00", imageName: "nike_air_more_uptempo_'96.png",
                manufacturerID: .nike, market: .shoes, cartIndicator: false, description: "Product #: J6129001\nBig Air\nThe Nike Air More Uptempo is one of the most memorable basketball sneakers of the 1990s. One look, and you’ll know why. Released in 1996, the Air More Uptempo featured the boldest and most unapologetic branding ever on a Nike shoe, and few have rivaled it since."),
        // Reeboks
        Product(title: "Aztrek", price: "80.00", imageName: "reebok_aztrek.png",
                manufacturerID: .reebok, market: .shoes, cartIndicator: false,
                description: "Product #: CN7067\nFlash your bold style with the Reebok Aztrek. Inspired by classic 90s looks, this lightweight runner lets you traverse a variety of terrains and look great doing it. Unique hexagonal cushioning softens each step, while the low-cut silhouette provides mobile, sophisticated style."),
        Product(title: "BB4600", price: "70.00", imageName: "reebok_bb4600.png",
                manufacturerID: .reebok, market: .shoes, cartIndicator: false, description: "Product #: FV7352\nShow off a modern shoe with retro vibes. Reebok’s BB4600 features a full-grain leather upper, while the tall collar creates a throwback look. A die-cut EVA midsole cushions each step, and the classic rubber outsole offers traction and grip."),
        Product(title: "Classic Leather", price: "75.00", imageName: "reebok_classic_leather.png",
                manufacturerID: .reebok, market: .shoes, cartIndicator: false, description: "Product #: 50171P\nNever go out of style.\n\nSoft garment leather upper gives you superior comfort.\nDie-cut EVA midsole provides lightweight cushioning.\nMolded PU sockliner adds comfort and durability."),
        Product(title: "Club C", price: "69.99", imageName: "reebok_club_c.png",
                manufacturerID: .reebok, market: .shoes, cartIndicator: false, description: "Product #: FX4012\nThe Reebok Club C tennis shoe fuses performance and lifestyle in a stylish on or off court shoe."),
        Product(title: "Question Mid", price: "75.00", imageName: "reebok_question_mid.png",
                manufacturerID: .reebok, market: .shoes, cartIndicator: false, description: "Product #: EG6274\nAchieve maximum Reebok style with the unbeatable Question Mid. The leather upper features unique gold accents and a comfortable mid-cut build. A chunky midsole and durable rubber outsole create an eye-catching silhouette, and Hexalite gives you cushioning and support with each step."),
        // Addidas
        Product(title: "Originals Hardcourt", price: "85.00", imageName: "adidas_originals_hardcourt.png",
                manufacturerID: .addidas, market: .shoes, cartIndicator: false, description: "Product #: FV6978\nCelebrate basketball-inspired style that goes above and beyond with the trendsetting Hardcourt from adidas Originals."),
        Product(title: "Originals NMD R1.V2", price: "130.00", imageName: "adidas_originals_nmd_R1.v2.png",
                manufacturerID: .addidas, market: .shoes, cartIndicator: false, description: "Product #: FX4148\nPut some pep in your step with the adidas Originals NMD R1.V2. The modern silhouette teams up with retro details to create a truly stand-out look. Your new favorite sneakers are right here."),
        Product(title: "Originals Pusha T Ozweego", price: "130.00", imageName: "adidas_originals_pusha_t_ozweego.png",
                manufacturerID: .addidas, market: .shoes, cartIndicator: false, description: "Product #: FV2484M\nRock a retro look with futuristic comfort in the adidas Originals Ozweego. Inspired by the late ’90s and early 2000s, this shoe shows off a mesh and suede upper that’s sure to turn some heads. This version reflects the vision of hip-hop artist Pusha T."),
        Product(title: "Originals Ultraboost 19", price: "180.00", imageName: "adidas_ultraboost_19.png",
                manufacturerID: .addidas, market: .shoes, cartIndicator: false, description: "Product #: FW0525\nRunning Has Never Been Easier\nPush your running to the next level with the adidas Ultra Boost 2019. Specifically designed to accommodate the running aficionado, these shoes feature all the right components to give you an extra boost with every stride – hence the name. "),
        Product(title: "Originals Ultraboost DNA", price: "180.00", imageName: "adidas_ultraboost_dna.png",
                manufacturerID: .addidas, market: .shoes, cartIndicator: false, description: "Product #: AQ5929\nThe adidas Ultraboost DNA is streamlined and sleek for amazing style and comfort while you run. These kicks are built to move naturally and provide support and comfort right where you need it."),
        // Jordan
        Product(title: "6 Rings", price: "170.00", imageName: "jordan_6_rings.png",
                manufacturerID: .jordan, market: .shoes, cartIndicator: false, description: "Product #: 22992012\nCount the Rings\nThe Men’s Jordan 6 Rings is a classic hybrid sneaker that combines all six of the Air Jordan models Michael Jordan wore en route to his six championships."),
        Product(title: "AJ 1 Mid SE", price: "125.00", imageName: "jordan_aj_1_mid_se.png",
                manufacturerID: .jordan, market: .shoes, cartIndicator: false, description: "Product #: W1140100\nTHE ICONIC AJ 1, MODERNIZED.\nThe Air Jordan 1 Mid SE for women takes the iconic design of the original AJ and updates it with premium materials and a bold, modern aesthetic."),
        Product(title: "Maxin 200", price: "130.00", imageName: "jordan_maxin_200.png",
                manufacturerID: .jordan, market: .shoes, cartIndicator: false, description: "Product #: D6107001\nHERITAGE-INSPIRED DESIGN, MAX COMFORT.\nWith a premium upper inspired by Jordan classics and big Air cushioning, the Jordan Maxin 200 shows off your Jordan pride and keeps every step comfortable."),
        Product(title: "Retro 3", price: "200.00", imageName: "jordan_retro_3.png",
                manufacturerID: .jordan, market: .shoes, cartIndicator: false, description: "Product #: K5692600\nA Sneaker For the Ages\nThe Men’s Air Jordan 3 Retro is one of the most beloved sneakers of all time. Almost any Air Jordan connoisseur will rank the Jordan 3 among their top five favorite models of the entire line. It’s truly one of the most iconic sneakers ever created, and a big reason sneaker culture exists as we know it today."),
        Product(title: "Retro 13", price: "190.00", imageName: "jordan_retro_9.png",
                manufacturerID: .jordan, market: .shoes, cartIndicator: false, description: "Product #: 14571030\nSneakers Fit for Anyone\nThe year Michael Jordan earned the nickname \"Black Cat\" was the year legendary shoe guru Tinker Hatfield decided to design the next Air Jordan after an actual panther, resulting in the Jordan Retro 13."),
        // Puma
        Product(title: "Clyde Hacked", price: "55.00", imageName: "puma_clyde_hacked.png",
                manufacturerID: .puma, market: .shoes, cartIndicator: false, description: ""),
        Product(title: "Defy Mid Buckle", price: "100.00", imageName: "puma_defy_mid_buckle.png",
                manufacturerID: .puma, market: .shoes, cartIndicator: false, description: "Product #: 19394401\nInstant Recognition\nThere’s no mistaking the PUMA Women’s Defy Mid Buckle. A game-changer at a glance, this eye-catching shoe is built to perform like a classic. It’s flexible, breathable, durable, supportive, and stylish all at once. More than that, it offers a funky and unexpected aesthetic that sets it apart from the other shoes in your closet."),
        Product(title: "Rider Sandal", price: "65.00", imageName: "puma_rider_sandal.png",
                manufacturerID: .puma, market: .shoes, cartIndicator: false, description: "Product #: 37196401\nEnjoy maximum comfort and unique style with PUMA’s Rider Sandal. Rider Foam in the midsole offers superior cushioning, while an anti-slip rubber outsole lets you tackle life’s adventures with confidence."),
        Product(title: "RS-X x Tetris", price: "95.00", imageName: "puma_rs_x_x_tetris.png",
                manufacturerID: .puma, market: .shoes, cartIndicator: false, description: "Product #: 37389701\nRetro Arcade-Inspired Style\nParents and kids alike can appreciate the PUMA Grade School RS-X x Tetris — a kids’ athletic sneaker made in collaboration with Tetris, the classic puzzle game from the ’80s. This kids’ sneaker celebrates the game’s 35th anniversary with two Tetris-themed colorways."),
        Product(title: "RS-X3", price: "110.00", imageName: "puma_rs_x3.png",
                manufacturerID: .puma, market: .shoes, cartIndicator: false, description: "Product #: 37157004\nPUMA’s revamping the iconic RS and bringing you the RS-X3. Mixed materials form an exciting and bold upper, while the classic rubber outsole offers traction and grip.")
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
