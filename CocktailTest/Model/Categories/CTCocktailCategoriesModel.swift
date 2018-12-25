//
//  CTCocktailCategoriesModel.swift
//  CocktailTest
//
//  Created by Daniel Moraleda on 19/11/18.
//  Copyright © 2018 Daniel Moraleda. All rights reserved.
//

import Foundation

/// A Model to store the cocktail types values.
class CTCocktailCategoriesModel: NSObject {
    private var categeriesList: [CTCocktailCategory]
    
    /// Base initializer
    override init() {
        self.categeriesList = [CTCocktailCategory]()
        
        super.init()
    }
    
    /// Replaces the categories of cocktail stored with new ones
    /// - Parameters:
    ///     - typeList: The new cocktail categories to store.
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
    
    /// Returns the number of categories stored.
    ///  - Returns: number of categories.
    func getCategoriesListCount() -> Int {
        return self.categeriesList.count
    }
    
    /// Retrieves a specific category of cocktail.
    /// - Parameters:
    ///     - index: The index of the category we want to get.
    /// - Returns: Cocktail category found on index.
    func getCategoryForIndex(_ index: Int) -> CTCocktailCategory? {
        if self.categeriesList.count > 0 {
            return self.categeriesList[index]
        }
        return nil
    }
}
