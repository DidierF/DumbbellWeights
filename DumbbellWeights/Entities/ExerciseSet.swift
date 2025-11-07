//
//  ExerciseSet.swift
//  DumbbellWeights
//
//  Created by Didier on 11/7/25.
//

import Foundation
import SwiftData

@Model
class ExerciseSet {
  @Relationship(inverse: \Exercise.sets) var exercise: Exercise
  var weight: Int
  var date: Date = Date.now

  init(exercise: Exercise, weight: Int) {
    self.exercise = exercise
    self.weight = weight
    self.exercise.updated = .now
  }
}
