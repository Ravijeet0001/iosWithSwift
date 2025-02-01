//
//  AddWorkoutView.swift
//  FitnessApp
//
//  Created by admin on 01/02/25.
//

import SwiftUI

struct AddWorkoutView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode

    @State private var workoutName: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Workout Name", text: $workoutName)
                }

                Section {
                    Button("Save") {
                        saveWorkout()
                    }
                }
            }
            .navigationTitle("Add Workout")
                        .navigationBarItems(leading: Button(action: {
                            presentationMode.wrappedValue.dismiss() // Dismisses the view (Back action)
                        }) {
                            Image(systemName: "chevron.left") // Adds a back arrow icon
                            Text("Back")
                        })
            
        }
    }

    private func saveWorkout() {
        guard !workoutName.isEmpty else { return }

        let newWorkout = Workout(context: viewContext)
        newWorkout.name = workoutName
        newWorkout.date = Date()

        do {
            try viewContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print("Failed to save workout: \(error.localizedDescription)")
        }
    }
}
