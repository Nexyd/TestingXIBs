//
//  CTAPICocktail.swift
//  CocktailTest
//
//  Created by Daniel Moraleda on 19/11/18.
//  Copyright © 2018 Daniel Moraleda. All rights reserved.
//

import Alamofire
import Unbox

extension CTAPI {

    /// Retrieves drinks from the API.
    /// - Parameters:
    ///     - completion: Callback method
    static func getCocktailCategories(_ completion: @escaping (_ response: CTCategoriesList?, _ error: NSError?) -> Void) {
        Alamofire.request(apiHsot() + "list.php", method: .get, parameters: ["c":"list"], encoding: URLEncoding.default, headers: nil).validate().responseJSON { (response) in
            switch response.result {
            case .success(let data):
                do {
                    if data is NSNull {
                        completion(nil, nil)
                    } else {
                        let elementsList: CTCategoriesList = try unbox(dictionary: data as! UnboxableDictionary)
                        completion(elementsList, nil)
                    }
                } catch {
                    completion(nil, NSError())
                }
            case .failure(let error):
                completion(nil, error as NSError)
            }
        }
    }
    
    /// Retrieves drinks from the API.
    /// - Parameters:
    ///     - filter: Filter used to change search type
    ///     - args: Values to filter.
    ///     - completion: Callback method
    static func getDrinks(filter: String, args: Dictionary<String, String>, _ completion: @escaping (_ response: CTTypesList?, _ error: NSError?) -> Void) {
        Alamofire.request(apiHsot() + filter, method: .get, parameters: args, encoding: URLEncoding.default, headers: nil).validate().responseJSON { (response) in
            switch response.result {
            case .success(let data):
                do {
                    if data is NSNull {
                        completion(nil, nil)
                    } else {
                        let elementsList: CTTypesList = try unbox(dictionary: data as! UnboxableDictionary)
                        completion(elementsList, nil)
                    }
                } catch {
                    completion(nil, NSError())
                }
            case .failure(let error):
                completion(nil, error as NSError)
            }
        }
    }
}
