//
//  CurrencyFormatter.swift
//  ShoeShock
//
//  Created by Jody Abney on 4/24/20.
//  Copyright © 2020 AbneyAnalytics. All rights reserved.
//

import Foundation

class CurrencyStringFormatter {
    
    // define a singleton
    static let instance = CurrencyStringFormatter()
    
    // define the currency formatter
    let cf: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .currency
        nf.currencySymbol = Locale.current.currencySymbol
        nf.currencyDecimalSeparator = Locale.current.decimalSeparator
        return nf
    }()
    
    // convert from a string and format
    func format(string numString: String) -> String {
        if let numDouble = Double(numString) {
            let num = NSNumber(value: numDouble)
            return cf.string(from: num)!
        } else {
            return ""
        }
    }
    
    // format from a double
    func format(double: Double) -> String {
        let num = NSNumber(value: double)
        return cf.string(from: num)!
    }
    
}

