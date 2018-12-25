//
//  CTCocktailTypeListModel.swift
//  CocktailTest
//
//  Created by Daniel Morato on 14/12/2018.
//  Copyright © 2018 Daniel Moraleda. All rights reserved.
//

import Foundation

/// A Model to store the cocktail types values.
class CTCocktailTypeModel: NSObject {
    private var typesList: [CTCocktailType]
    
    /// Base initializer
    override init() {
        self.typesList = [CTCocktailType]()
        
        super.init()
    }
    
    /// Replaces the types of cocktail stored with new ones
    /// - Parameters:
    ///     - typeList: The new cocktail types to store.
    func setTypeList(typeList: [CTCocktailType]?) {
        self.typesList.removeAll()
        if let list = typeList {
            if list.count > 0 {
                for type in list {
                    self.typesList.append(type)
                }
            }
        }
    }
    
    /// Returns the number of types stored.
    ///  - Returns: number of types.
    func getTypeListCount() -> Int {
        return self.typesList.count
    }
    
    /// Retrieves a specific type of cocktail.
    /// - Parameters:
    ///     - index: The index of the type we want to get.
    /// - Returns: Cocktail type found on index.
    func getTypeForIndex(_ index: Int) -> CTCocktailType? {
        if self.typesList.count > 0 {
            return self.typesList[index]
        }
        
        return nil
    }
}
