//
//  CategoryListView.swift
//  DumbbellWeights
//
//  Created by Didier on 9/5/25.
//


import SwiftUI
import SwiftData

struct WorkoutListView: View {
    // Fetch all workouts, sorted by name
    @Query(sort: \WorkoutTemplate.title) var workouts: [WorkoutTemplate]

    var body: some View {
        NavigationStack {
            List {
                ForEach(workouts) { workout in
                  Section(header: Text(workout.title).font(.headline)) {
                        if workout.exercises.isEmpty {
                            Text("No items").foregroundStyle(.secondary)
                        } else {
                            ForEach(workout.exercises) { ex in
                              HStack {
                                Text(ex.name + " - " + ex.target.rawValue)
                              }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Workouts")
        }
    }
}
