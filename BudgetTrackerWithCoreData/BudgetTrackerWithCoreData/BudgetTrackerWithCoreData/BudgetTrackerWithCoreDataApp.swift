//
//  BudgetTrackerWithCoreDataApp.swift
//  BudgetTrackerWithCoreData
//
//  Created by admin on 31/01/25.
//

import SwiftUI

@main
struct BudgetTrackerWithCoreDataApp: App {
    let persistentController = PersistenceController.shared
          
        var body: some Scene {
            WindowGroup {
                TransactionsView()
                    .environment(\.managedObjectContext, persistentController.container.viewContext)
            }
        }
    
}
