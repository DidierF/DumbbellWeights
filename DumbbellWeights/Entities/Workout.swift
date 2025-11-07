//
//  WorkoutTemplate.swift
//  DumbbellWeights
//
//  Created by Didier on 8/31/25.
//

import Foundation
import SwiftData

@Model
class Workout {
  var date: Date = Date.now
  var sets: [ExerciseSet] = []

  init() {}
}
