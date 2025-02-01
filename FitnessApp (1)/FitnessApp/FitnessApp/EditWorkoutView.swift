//
//  EditWorkoutView.swift
//  FitnessApp
//
//  Created by admin on 01/02/25.
//

import SwiftUI

struct EditWorkoutView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var workout: Workout
    @State private var workoutName: String

    init(workout: Workout) {
        self.workout = workout
        _workoutName = State(initialValue: workout.name ?? "")
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Workout Name", text: $workoutName)
                }

                Section {
                    Button("Save Changes") {
                        saveChanges()
                    }
                }
            }
            .navigationTitle("Edit Workout")
        }
    }

    private func saveChanges() {
        workout.name = workoutName

        do {
            try viewContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print("Failed to save workout changes: \(error.localizedDescription)")
        }
    }
}
