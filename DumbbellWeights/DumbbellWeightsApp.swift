//
//  DumbbellWeightsApp.swift
//  DumbbellWeights
//
//  Created by Didier on 8/28/25.
//

import SwiftUI
import SwiftData

@main
struct DumbbellWeightsApp: App {
  var body: some Scene {
    WindowGroup {
      NavigationStack {
        ExercisesView()
          .modelContainer(for: [Exercise.self])
          .task {
            await PreloadData()
          }
      }
    }
  }

  @MainActor
  private func PreloadData() async {

    let container = try! ModelContainer(for: Exercise.self)
    let context = ModelContext(container)
    let fetchDescriptor = FetchDescriptor<Exercise>()

    let currentExercises = try? context.fetch(fetchDescriptor)

    let allExercises = WorkoutService().GetExercises()

    for exercise in allExercises {
      if !currentExercises!.contains(where: { e in
        e.name == exercise
      }) {
        let newEx = Exercise(exercise)
        context.insert(newEx)
      }
    }
  }
}
