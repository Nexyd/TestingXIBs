//
//  CTCocktailTypeListModel.swift
//  CocktailTest
//
//  Created by Daniel Morato on 14/12/2018.
//  Copyright © 2018 Daniel Moraleda. All rights reserved.
//

import Foundation

class CTCocktailTypeModel: NSObject {
    private var typesList: [CTCocktailType]
    
    override init() {
        self.typesList = [CTCocktailType]()
        
        super.init()
    }
    
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
    
    func getTypeListCount() -> Int {
        return self.typesList.count
    }
    
    func getTypeForIndex(_ index: Int) -> CTCocktailType? {
        if self.typesList.count > 0 {
            return self.typesList[index]
        }
        return nil
    }
}
