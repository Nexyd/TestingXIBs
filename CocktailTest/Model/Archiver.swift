//
//  Archiver.swift
//  CocktailTest
//
//  Created by Daniel Morato on 14/12/2018.
//  Copyright © 2018 Daniel Moraleda. All rights reserved.
//

import Foundation

class Archiver {
    static func store(element: [NSCoding], as key: String) {
        let data = NSKeyedArchiver.archivedData(withRootObject: element)
        UserDefaults.standard.set(data, forKey: key)
    }

    static func Exists(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }

    static func retrieveElement(forKey key: String) -> [NSCoding] {
        let data = UserDefaults.standard.value(forKey: key)
        let element = NSKeyedUnarchiver.unarchiveObject(with: data as! Data)

        return element as! [NSCoding]
    }
}
