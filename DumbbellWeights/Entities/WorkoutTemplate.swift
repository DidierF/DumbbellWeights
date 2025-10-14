//
//  WorkoutTemplate.swift
//  DumbbellWeights
//
//  Created by Didier on 8/31/25.
//

import Foundation
import SwiftData

@Model
class Exercise {
  var name: String

  init(_ name: String) {
    self.name = name
  }
}

@Model
class ExerciseSet {
  var exercise: Exercise
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
