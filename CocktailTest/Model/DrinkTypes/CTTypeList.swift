//
//  CTCocktailTypeList.swift
//  CocktailTest
//
//  Created by Daniel Morato on 14/12/2018.
//  Copyright © 2018 Daniel Moraleda. All rights reserved.
//

import Foundation
import Unbox

/// A persistent Cocktail type list
class CTTypesList: NSObject, NSCoding, Unboxable {
    
    private var drinksList: [CTCocktailType]?
    
    /// Initializer from Unboxer
    /// Required from parent
    /// - Parameters:
    ///     - unboxer: The unboxer to be used.
    required init(unboxer: Unboxer) throws {
        self.drinksList = unboxer.unbox(key: "drinks")
    }
    
    /// Initializer from NSDecoder
    /// Required from parent
    /// - Parameters:
    ///     - aDecoder: The decoder to be used.
    required init?(coder aDecoder: NSCoder) {
        self.drinksList = aDecoder.decodeObject(forKey: "drinks") as? [CTCocktailType]
    }
    
    /// Encodes data with the passed NSCoder.
    /// - Parameters:
    ///     - aCoder: The coder to be used.
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.drinksList, forKey: "drinks")
    }
    
    /// Returns the drink list.
    ///  - Returns: drink list
    func getDrinks() -> [CTCocktailType]? {
        return drinksList
    }
}

