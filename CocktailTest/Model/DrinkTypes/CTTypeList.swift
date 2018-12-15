//
//  CTCocktailTypeList.swift
//  CocktailTest
//
//  Created by Daniel Morato on 14/12/2018.
//  Copyright © 2018 Daniel Moraleda. All rights reserved.
//

import Foundation
import Unbox

class CTTypesList: NSObject, NSCoding, Unboxable {
    
    private var drinksList: [CTCocktailType]?
    
    required init(unboxer: Unboxer) throws {
        self.drinksList = unboxer.unbox(key: "drinks")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.drinksList = aDecoder.decodeObject(forKey: "drinks") as? [CTCocktailType]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.drinksList, forKey: "drinks")
    }
    
    func getDrinks() -> [CTCocktailType]? {
        return drinksList
    }
}

