//
//  CTCocktailCategory.swift
//  CocktailTest
//
//  Created by Daniel Moraleda on 19/11/18.
//  Copyright © 2018 Daniel Moraleda. All rights reserved.
//

import Foundation
import Unbox

/// A persistent Cocktail category
class CTCocktailCategory: NSObject, NSCoding, Unboxable {
    
    private var categoryStr: String = ""
    
    override var description: String {
        return "[\(categoryStr)]"
    }
    
    /// Initializer from Unboxer
    /// Required from parent
    /// - Parameters:
    ///     - unboxer: The unboxer to be used.
    required init(unboxer: Unboxer) throws {
        self.categoryStr = try unboxer.unbox(key: "strCategory")
    }
    
    /// Initializer from NSCoder
    /// Required from parent
    /// - Parameters:
    ///     - aDecoder: The decoder to be used.
    required init?(coder aDecoder: NSCoder) {
        self.categoryStr = aDecoder.decodeObject(forKey: "strCategory") as! String
    }
    
    /// Encodes data with the passed NSCoder.
    /// - Parameters:
    ///     - aCoder: The coder to be used.
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.categoryStr, forKey: "strCategory")
    }
    
    /// Returns the drink category.
    ///  - Returns: drink category
    func getCategory() -> String {
        return categoryStr
    }
}
