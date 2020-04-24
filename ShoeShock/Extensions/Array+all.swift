//
//  Array+all.swift
//  ShoeShock
//
//  Created by Jody Abney on 4/22/20.
//  Copyright © 2020 AbneyAnalytics. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    func all(where predicate: (Element) -> Bool) -> [Element]  {
        return self.compactMap { predicate($0) ? $0 : nil }
    }
}
