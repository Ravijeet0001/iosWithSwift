//
//  ExerciseListView.swift
//  FitnessApp
//
//  Created by admin on 01/02/25.
//

import SwiftUI
import CoreData

struct ExerciseListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var workout: Workout

    @State private var isShowingAddExercise = false
    @State private var isShowingEditExercise = false
    @State private var selectedExercise: Exercise?

    var body: some View {
        VStack {
            List {
                ForEach(workout.exercisesArray, id: \.self) { exercise in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(exercise.name ?? "Unnamed Exercise")
                                .font(.headline)
                            Text("\(exercise.sets) sets, \(exercise.reps) reps")
                                .font(.subheadline)
                        }
                        Spacer()
                        Button(action: {
                            selectedExercise = exercise
                            isShowingEditExercise = true
                        }) {
                            Image(systemName: "pencil")
                                .foregroundColor(.blue)
                        }
                    }
                }
                .onDelete(perform: deleteExercises)
            }
            .navigationTitle(workout.name ?? "Workout")
            .navigationBarItems(
                trailing: Button(action: { isShowingAddExercise = true }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $isShowingAddExercise) {
                AddExerciseView(workout: workout)
            }
            .sheet(item: $selectedExercise) { exercise in
                EditExerciseView(exercise: exercise)
            }
        }
    }

    private func deleteExercises(at offsets: IndexSet) {
        for index in offsets {
            let exercise = workout.exercisesArray[index]
            viewContext.delete(exercise)
        }
        do {
            try viewContext.save()
        } catch {
            print("Failed to delete exercise: \(error.localizedDescription)")
        }
    }
}
