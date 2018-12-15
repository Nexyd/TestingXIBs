//
//  CTCocktailCategory.swift
//  CocktailTest
//
//  Created by Daniel Moraleda on 19/11/18.
//  Copyright © 2018 Daniel Moraleda. All rights reserved.
//

import Foundation
import Unbox

class CTCocktailCategory: NSObject, NSCoding, Unboxable {
    
    private var categoryStr: String = ""
    
    override var description: String {
        return "[\(categoryStr)]"
    }
    
    required init(unboxer: Unboxer) throws {
        self.categoryStr = try unboxer.unbox(key: "strCategory")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.categoryStr = aDecoder.decodeObject(forKey: "strCategory") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.categoryStr, forKey: "strCategory")
    }
    
    func getCategory() -> String {
        return categoryStr
    }
}
