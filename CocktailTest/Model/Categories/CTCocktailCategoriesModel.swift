//
//  CTCocktailCategoriesModel.swift
//  CocktailTest
//
//  Created by Daniel Moraleda on 19/11/18.
//  Copyright © 2018 Daniel Moraleda. All rights reserved.
//

import Foundation

class CTCocktailCategoriesModel: NSObject {
    private var categeriesList: [CTCocktailCategory]
    
    override init() {
        self.categeriesList = [CTCocktailCategory]()
        
        super.init()
    }
    
    func setCategoriesList(catList: [CTCocktailCategory]?) {
        self.categeriesList.removeAll()
        if let list = catList {
            if list.count > 0 {
                for category in list {
                    self.categeriesList.append(category)
                }
            }
        }
    }
    
    func getCategoriesListCount() -> Int {
        return self.categeriesList.count
    }
    
    func getCategoryForIndex(_ index: Int) -> CTCocktailCategory? {
        if self.categeriesList.count > 0 {
            return self.categeriesList[index]
        }
        return nil
    }
}
