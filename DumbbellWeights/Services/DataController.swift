//
//  DataController.swift
//  DumbbellWeights
//
//  Created by Didier on 10/3/25.
//

import SwiftData

@MainActor
class DataController {
  static let previewContainer: ModelContainer = {
    do {
      let config = ModelConfiguration(isStoredInMemoryOnly: true)
      let container = try ModelContainer(
        for: Exercise.self,
        Workout.self,
        configurations: config
      )

      var muscle1 = Muscle("Muscle 1")
      var muscle2 = Muscle("Muscle 2")
      var muscle3 = Muscle("Muscle 3")
      var muscle4 = Muscle("Muscle 4")

      var exercises: [Exercise] = []

      for i in 1...25 {
        let ex = Exercise(
          "Exercise \(i)",
          muscle: [muscle1, muscle2, muscle3, muscle4].randomElement()!
        )
        container.mainContext.insert(ex)
        exercises.append(ex)
      }

      for i in 1...10 {
        let w = Workout()
        w.sets = [
          ExerciseSet(exercise: exercises.randomElement()!, weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: exercises.randomElement()!, weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: exercises.randomElement()!, weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: exercises.randomElement()!, weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: exercises.randomElement()!, weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: exercises.randomElement()!, weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: exercises.randomElement()!, weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: exercises.randomElement()!, weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: exercises.randomElement()!, weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: exercises.randomElement()!, weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: exercises.randomElement()!, weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: exercises.randomElement()!, weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: exercises.randomElement()!, weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: exercises.randomElement()!, weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: exercises.randomElement()!, weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: exercises.randomElement()!, weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: exercises.randomElement()!, weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: exercises.randomElement()!, weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: exercises.randomElement()!, weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: exercises.randomElement()!, weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: exercises.randomElement()!, weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: exercises.randomElement()!, weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: exercises.randomElement()!, weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: exercises.randomElement()!, weight: Int.random(in: 20...90)),

          ExerciseSet(exercise: exercises.randomElement()!, weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: exercises.randomElement()!, weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: exercises.randomElement()!, weight: Int.random(in: 20...90)),

          ExerciseSet(exercise: exercises.randomElement()!, weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: exercises.randomElement()!, weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: exercises.randomElement()!, weight: Int.random(in: 20...90)),

          ExerciseSet(exercise: exercises.randomElement()!, weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: exercises.randomElement()!, weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: exercises.randomElement()!, weight: Int.random(in: 20...90)),
        ]
        container.mainContext.insert(w)
      }

      return container
    } catch {
      fatalError("Failed to create model container for previewing: \(error.localizedDescription)")
    }
  }()
}
