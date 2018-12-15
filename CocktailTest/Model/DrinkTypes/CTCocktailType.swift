//
//  CTCocktailType.swift
//  CocktailTest
//
//  Created by Daniel Morato on 14/12/2018.
//  Copyright © 2018 Daniel Moraleda. All rights reserved.
//

import Foundation
import Unbox

class CTCocktailType: NSObject, NSCoding, Unboxable {
    
    private var drink: String = ""
    private var drinkThumb: String = ""
    private var drinkId: Int
    
    override var description: String {
        return "[\(drink)]"
    }
    
    required init(unboxer: Unboxer) throws {
        self.drink = try unboxer.unbox(key: "strDrink")
        self.drinkThumb = try unboxer.unbox(key: "strDrinkThumb")
        self.drinkId = try unboxer.unbox(key: "idDrink")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.drink = aDecoder.decodeObject(forKey: "strDrink") as! String
        self.drinkThumb = aDecoder.decodeObject(forKey: "strDrinkThumb") as! String
        self.drinkId = aDecoder.decodeObject(forKey: "idDrink") as! Int
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.drink, forKey: "strDrink")
        aCoder.encode(self.drinkThumb, forKey: "strDrinkThumb")
        aCoder.encode(self.drinkId, forKey: "idDrink")
    }
    
    func getDrink() -> String {
        return drink
    }
    
    func getDrinkThumb() -> String {
        return drinkThumb
    }
    
    func getDrinkId() -> Int {
        return drinkId
    }
}
