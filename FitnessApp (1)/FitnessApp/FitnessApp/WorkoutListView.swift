//
//  WorkoutListView.swift
//  FitnessApp
//
//  Created by admin on 01/02/25.
//

import SwiftUI
import CoreData

struct WorkoutListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Workout.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Workout.date, ascending: false)]
    ) private var workouts: FetchedResults<Workout>

    @State private var isShowingAddWorkout = false
    @State private var isShowingEditWorkout = false
    @State private var selectedWorkout: Workout?

    var body: some View {
        NavigationView {
            List {
                ForEach(workouts) { workout in
                    HStack {
                        // ✅ NavigationLink for navigating to ExerciseListView
                        NavigationLink(destination: ExerciseListView(workout: workout)) {
                            VStack(alignment: .leading) {
                                Text(workout.name ?? "Unnamed Workout")
                                    .font(.headline)
                                Text("\(workout.date ?? Date(), formatter: workoutDateFormatter)")
                                    .font(.subheadline)
                            }
                        }
                        
                        Spacer()
                        
                        // ✅ Separate Edit Button
                        Button(action: {
                            selectedWorkout = workout
                            isShowingEditWorkout = true
                        }) {
                            Image(systemName: "pencil")
                                .foregroundColor(.blue)
                        }
                        .buttonStyle(BorderlessButtonStyle()) // Prevents conflicting taps
                    }
                }
                .onDelete(perform: deleteWorkouts)
            }
            .navigationTitle("Workouts")
            .navigationBarItems(
                leading: EditButton(),
                trailing: Button(action: { isShowingAddWorkout = true }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $isShowingAddWorkout) {
                AddWorkoutView()
            }
            .sheet(item: $selectedWorkout) { workout in
                EditWorkoutView(workout: workout)
            }
        }
    }

    private func deleteWorkouts(at offsets: IndexSet) {
        for index in offsets {
            let workout = workouts[index]
            viewContext.delete(workout)
        }
        saveContext()
    }

    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Failed to save context: \(error.localizedDescription)")
        }
    }

    private let workoutDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
}
