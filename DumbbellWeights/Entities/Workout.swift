//
//  Workout.swift
//  DumbbellWeights
//
//  Created by Didier on 8/31/25.
//

import Foundation

class Workout {
  var exercises: [Exercise] = []

  init(exercises: [Exercise]) {
    self.exercises = exercises
  }

}

class UpperBodyWorkout: Workout {
  init() {
    super.init(exercises: [
      Exercise("Chest Press"),
      Exercise("Back Rows"),
      Exercise("Curls"),
      Exercise("Overhead Rises")
    ])
  }
}

class Exercise {
  var name: String = ""

  init(_ name: String) {
    self.name = name
  }
}
