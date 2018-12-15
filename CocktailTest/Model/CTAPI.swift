//
//  CTAPI.swift
//  CocktailTest
//
//  Created by Daniel Moraleda on 19/11/18.
//  Copyright © 2018 Daniel Moraleda. All rights reserved.
//

import Alamofire

class CTAPI: NSObject {
    
    static func apiHsot() -> String {
        return CTConstants.ApiUrls.API_ROOT
    }
}
