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

      for i in 1...25 {
        let ex = Exercise("Exercise \(i)")
        container.mainContext.insert(ex)
      }

      for i in 1...10 {
        let w = Workout()
        w.sets = [
          ExerciseSet(exercise: Exercise("Exercise1\(i)"), weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: Exercise("Exercise1\(i)"), weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: Exercise("Exercise1\(i)"), weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: Exercise("Exercise1\(i)"), weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: Exercise("Exercise1\(i)"), weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: Exercise("Exercise1\(i)"), weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: Exercise("Exercise1\(i)"), weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: Exercise("Exercise1\(i)"), weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: Exercise("Exercise1\(i)"), weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: Exercise("Exercise1\(i)"), weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: Exercise("Exercise1\(i)"), weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: Exercise("Exercise1\(i)"), weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: Exercise("Exercise1\(i)"), weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: Exercise("Exercise1\(i)"), weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: Exercise("Exercise1\(i)"), weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: Exercise("Exercise1\(i)"), weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: Exercise("Exercise1\(i)"), weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: Exercise("Exercise1\(i)"), weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: Exercise("Exercise1\(i)"), weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: Exercise("Exercise1\(i)"), weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: Exercise("Exercise1\(i)"), weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: Exercise("Exercise1\(i)"), weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: Exercise("Exercise1\(i)"), weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: Exercise("Exercise1\(i)"), weight: Int.random(in: 20...90)),

          ExerciseSet(exercise: Exercise("Exercise2\(i)"), weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: Exercise("Exercise2\(i)"), weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: Exercise("Exercise2\(i)"), weight: Int.random(in: 20...90)),

          ExerciseSet(exercise: Exercise("Exercise3\(i)"), weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: Exercise("Exercise3\(i)"), weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: Exercise("Exercise3\(i)"), weight: Int.random(in: 20...90)),

          ExerciseSet(exercise: Exercise("Exercise4\(i)"), weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: Exercise("Exercise4\(i)"), weight: Int.random(in: 20...90)),
          ExerciseSet(exercise: Exercise("Exercise4\(i)"), weight: Int.random(in: 20...90)),
        ]
        container.mainContext.insert(w)
      }

      return container
    } catch {
      fatalError("Failed to create model container for previewing: \(error.localizedDescription)")
    }
  }()
}
