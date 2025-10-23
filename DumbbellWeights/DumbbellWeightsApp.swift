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
      HomeTabView()
        .modelContainer(for: [Workout.self, ExerciseSet.self, Exercise.self])
        .task {
          await PreloadData()
        }
    }
  }

  @MainActor
  private func PreloadData() async {
    let container = try! ModelContainer(for: Exercise.self, Muscle.self)
    let context = ModelContext(container)
    let fetchDescriptor = FetchDescriptor<Exercise>()
    let muscleDescriptor = FetchDescriptor<Muscle>()

    let currentExercises = try? context.fetch(fetchDescriptor)
    var currentMuscles = try? context.fetch(muscleDescriptor)

    let allExercises = WorkoutService().GetExercises()

    for exercise in allExercises {
      let name = exercise[0]
      let muscleName = exercise[1]

      var muscle = currentMuscles!.first(where: { m in
        m.name == muscleName
      })

      if muscle == nil {
        muscle = Muscle(muscleName)
        context.insert(muscle!)
        currentMuscles = try? context.fetch(muscleDescriptor)
      }

      let storedExercise = currentExercises!.first { e in
        e.name == name
      }

      if storedExercise == nil {
        let newEx = Exercise(name, muscle: muscle!)
        context.insert(newEx)
      } else {
        storedExercise?.muscle = muscle!
      }
    }
  }
}
