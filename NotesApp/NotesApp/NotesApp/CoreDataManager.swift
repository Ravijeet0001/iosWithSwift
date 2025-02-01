//
//  CoreDataManager.swift
//  NotesApp
//
//  Created by admin on 01/02/25.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer

    private init() {
        persistentContainer = NSPersistentContainer(name: "NotesModel")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
    }

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save context: \(error)")
            }
        }
    }

    func createNote(title: String, content: String) {
        let note = Note(context: context)
        note.title = title
        note.content = content
        note.dateCreated = Date()
        saveContext()
    }

    func deleteNote(_ note: Note) {
        context.delete(note)
        saveContext()
    }
}
