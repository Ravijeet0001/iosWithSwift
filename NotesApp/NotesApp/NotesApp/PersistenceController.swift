//
//  PersistenceController.swift
//  NotesApp
//
//  Created by admin on 01/02/25.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController() // Singleton instance

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "NotesModel") 
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }

    var context: NSManagedObjectContext {
        return container.viewContext
    }
}
