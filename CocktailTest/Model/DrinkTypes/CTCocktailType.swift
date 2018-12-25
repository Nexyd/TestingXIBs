//
//  CTCocktailType.swift
//  CocktailTest
//
//  Created by Daniel Morato on 14/12/2018.
//  Copyright © 2018 Daniel Moraleda. All rights reserved.
//

import Foundation
import Unbox

/// A persistent Cocktail type
class CTCocktailType: NSObject, NSCoding, Unboxable {
    
    private var drink: String = ""
    private var drinkThumb: String = ""
    private var drinkId: Int
    
    override var description: String {
        return "[\(drink)]"
    }
    
    /// Initializer from Unboxer
    /// Required from parent
    /// - Parameters:
    ///     - unboxer: The unboxer to be used.
    required init(unboxer: Unboxer) throws {
        self.drink = try unboxer.unbox(key: "strDrink")
        self.drinkThumb = try unboxer.unbox(key: "strDrinkThumb")
        self.drinkId = try unboxer.unbox(key: "idDrink")
    }
    
    /// Initializer from NSCoder
    /// Required from parent
    /// - Parameters:
    ///     - aDecoder: The decoder to be used.
    required init?(coder aDecoder: NSCoder) {
        self.drink = aDecoder.decodeObject(forKey: "strDrink") as! String
        self.drinkThumb = aDecoder.decodeObject(forKey: "strDrinkThumb") as! String
        self.drinkId = aDecoder.decodeObject(forKey: "idDrink") as! Int
    }
    
    /// Encodes data with the passed NSCoder.
    /// - Parameters:
    ///     - aCoder: The coder to be used.
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.drink, forKey: "strDrink")
        aCoder.encode(self.drinkThumb, forKey: "strDrinkThumb")
        aCoder.encode(self.drinkId, forKey: "idDrink")
    }
    
    /// Returns the drink name.
    ///  - Returns: drink name
    func getDrink() -> String {
        return drink
    }
    
    /// Returns the drink image thumb.
    ///  - Returns: drink image thumb
    func getDrinkThumb() -> String {
        return drinkThumb
    }
    
    /// Returns the drink id.
    ///  - Returns: drink id
    func getDrinkId() -> Int {
        return drinkId
    }
}
