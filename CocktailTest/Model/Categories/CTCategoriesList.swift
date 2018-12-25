//
//  CTCategoriesList.swift
//  CocktailTest
//
//  Created by Daniel Moraleda on 19/11/18.
//  Copyright © 2018 Daniel Moraleda. All rights reserved.
//

import Foundation
import Unbox

/// A persistent Cocktail categories list
class CTCategoriesList: NSObject, NSCoding, Unboxable {
    
    private var drinksList: [CTCocktailCategory]?
    
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
        self.drinksList = aDecoder.decodeObject(forKey: "drinks") as? [CTCocktailCategory]
    }
    
    /// Encodes data with the passed NSCoder.
    /// - Parameters:
    ///     - aCoder: The coder to be used.
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.drinksList, forKey: "drinks")
    }
    
    /// Returns the drink categories.
    ///  - Returns: drink categories
    func getCategoriesList() -> [CTCocktailCategory]? {
        return drinksList
    }
}
