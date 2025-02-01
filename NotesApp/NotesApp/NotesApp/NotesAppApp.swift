//
//  NotesAppApp.swift
//  NotesApp
//
//  Created by admin on 01/02/25.
//

import SwiftUI

@main
struct NotesAppApp: App {
    let persistenceController = CoreDataManager.shared

        var body: some Scene {
            WindowGroup {
                NoteListView()
                    .environment(\.managedObjectContext, persistenceController.context)
            }
        }
    
}
