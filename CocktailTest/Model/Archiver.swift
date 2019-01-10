//
//  Archiver.swift
//  CocktailTest
//
//  Created by Daniel Morato on 14/12/2018.
//  Copyright © 2018 Daniel Moraleda. All rights reserved.
//

import UIKit
import CoreData

/// This class saves NSCoding objects in CoreData
class Archiver {

    /// Stores data in the CoreData with a specific key.
    /// - Parameters:
    ///     - element: the element we're going to store.
    ///     - entity:  the entity in which we're going to store the element.
    ///     - field:   the field of the entity selected.
    static func store(elements: [NSCoding], forEntity entity: String, field: String) {
        var categoriesEntity: [NSManagedObject] = []
        guard let appDelegate = UIApplication.shared.delegate
            as? AppDelegate else { return }

        // let managedContext = NSManagedObjectContext(
        //    concurrencyType: .mainQueueConcurrencyType)
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(
            forEntityName: entity, in: managedContext)

        for element in elements {
            let category = NSManagedObject(entity:
                entity!, insertInto: managedContext)

            category.setValue(element, forKeyPath: field)

            do {
                try managedContext.save()
                categoriesEntity.append(category)
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }

    /// Checks the CoreData model for a specific entity.
    /// - Parameters:
    ///     - key: The entity we're looking for.
    /// - Returns: True if has data, False if not.
    static func hasData(for entity: String) -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        
        let output = try? context.fetch(request)
        let result = (output?.count == 0) ? true : false
        
        return result
    }

    /// Retrieves an element from the CoreData store.
    /// - Parameters:
    ///     - name: The name of the entity we want to get.
    /// - Returns: Entity's content.
    static func retrieveEntity(withName name: String) -> [NSCoding]? {
        guard let appDelegate = UIApplication.shared.delegate
            as? AppDelegate else { return nil }

        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: name)
        var categories: [NSCoding] = []

        do {
            categories = try (managedContext.fetch(fetchRequest) as! [NSCoding])
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return categories
    }
}
