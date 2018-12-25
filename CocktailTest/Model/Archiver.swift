//
//  Archiver.swift
//  CocktailTest
//
//  Created by Daniel Morato on 14/12/2018.
//  Copyright © 2018 Daniel Moraleda. All rights reserved.
//

import Foundation

/// This class saves NSCoding objects in UserDefaults
class Archiver {

    /// Stores data in the UserDefaults with a specific key.
    /// - Parameters:
    ///     - element: the element we're going to store.
    ///     - key:  the key associated to the element.
    static func store(element: [NSCoding], as key: String) {
        let data = NSKeyedArchiver.archivedData(withRootObject: element)
        UserDefaults.standard.set(data, forKey: key)
    }

    /// Checks the UserDefaults store for a specific key.
    /// - Parameters:
    ///     - key: The key we're looking for.
    /// - Returns: True if found, False if not.
    static func Exists(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }

    /// Retrieves an element from the UserDefaults store.
    /// - Parameters:
    ///     - key: The key we want to get.
    /// - Returns: Assigned value of key if found.
    static func retrieveElement(forKey key: String) -> [NSCoding] {
        var element: [NSCoding] = []
        
        if (Exists(key: key)) {
            let data = UserDefaults.standard.value(forKey: key)
            element = NSKeyedUnarchiver.unarchiveObject(
                with: data as! Data) as! [NSCoding]
        } else {
            print("The key \(key) was not found")
        }
        
        return element
    }
}
