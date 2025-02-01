//
//  EditExerciseView.swift
//  FitnessApp
//
//  Created by admin on 01/02/25.
//

import SwiftUI

struct EditExerciseView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var exercise: Exercise

    @State private var exerciseName: String
    @State private var sets: Int
    @State private var reps: Int

    init(exercise: Exercise) {
        self.exercise = exercise
        _exerciseName = State(initialValue: exercise.name ?? "")
        _sets = State(initialValue: Int(exercise.sets))
        _reps = State(initialValue: Int(exercise.reps))
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Exercise Name", text: $exerciseName)
                    Stepper("Sets: \(sets)", value: $sets, in: 1...100)
                    Stepper("Reps: \(reps)", value: $reps, in: 1...100)
                }

                Section {
                    Button("Save Changes") {
                        saveChanges()
                    }
                }
            }
            .navigationTitle("Edit Exercise")
        }
    }

    private func saveChanges() {
        exercise.name = exerciseName
        exercise.sets = Int32(sets)
        exercise.reps = Int32(reps)

        do {
            try viewContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print("Failed to save changes: \(error.localizedDescription)")
        }
    }
}
