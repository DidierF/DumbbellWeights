//
//  Exercise.swift
//  DumbbellWeights
//
//  Created by Didier on 11/7/25.
//

import Foundation
import SwiftData

@Model
class Exercise {
  var name: String
  var muscle: Muscle?
  var sets: [ExerciseSet]?
  var updated: Date = Date.now

  var sortedSets: [ExerciseSet] {
    sets?.sorted(by: { $0.date < $1.date }) ?? []
  }

  init(_ name: String, muscle: Muscle) {
    self.name = name
    self.muscle = muscle
  }
}
