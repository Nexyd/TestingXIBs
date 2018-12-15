//
//  CTCategoriesList.swift
//  CocktailTest
//
//  Created by Daniel Moraleda on 19/11/18.
//  Copyright © 2018 Daniel Moraleda. All rights reserved.
//

import Foundation
import Unbox

class CTCategoriesList: NSObject, NSCoding, Unboxable {
    
    private var drinksList: [CTCocktailCategory]?
    
    required init(unboxer: Unboxer) throws {
        self.drinksList = unboxer.unbox(key: "drinks")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.drinksList = aDecoder.decodeObject(forKey: "drinks") as? [CTCocktailCategory]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.drinksList, forKey: "drinks")
    }
    
    func getCategoriesList() -> [CTCocktailCategory]? {
        return drinksList
    }
}
