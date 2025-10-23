//
//  WorkoutTemplate.swift
//  DumbbellWeights
//
//  Created by Didier on 8/31/25.
//

import Foundation
import SwiftData

@Model
class Muscle {
  var name: String
  var exercises: [Exercise]?

  init(_ name: String) {
    self.name = name
  }
}

@Model
class Exercise {
  var name: String
  var muscle: Muscle?
  var sets: [ExerciseSet]?

  init(_ name: String, muscle: Muscle) {
    self.name = name
    self.muscle = muscle
  }
}

@Model
class ExerciseSet {
  @Relationship(inverse: \Exercise.sets) var exercise: Exercise
  var weight: Int
  var date: Date = Date.now

  init(exercise: Exercise, weight: Int) {
    self.exercise = exercise
    self.weight = weight
  }
}

@Model
class Workout {
  var date: Date = Date.now
  var sets: [ExerciseSet] = []

  init() {}
}
