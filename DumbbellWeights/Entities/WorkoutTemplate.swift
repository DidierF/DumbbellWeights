//
//  WorkoutTemplate.swift
//  DumbbellWeights
//
//  Created by Didier on 8/31/25.
//

import Foundation
import SwiftData

@Model
class WorkoutTemplate {
  var title: String
  var exercises: [Exercise] = []

  init(_ title: String) {
    self.title = title
  }

}

@Model
class Exercise {
  var name: String
  var target: Muscle
  var secondaryTargets: [String] = []

  init(_ name: String, target: Muscle) {
    self.name = name
    self.target = target
  }
}

@Model
class ExerciseSet {
  var exercise: Exercise
  var weight: Int
  var reps: Int

  init(exercise: Exercise, weight: Int, reps: Int) {
    self.exercise = exercise
    self.weight = weight
    self.reps = reps
  }
}

@Model
class Workout {
  var date: Date = Date()
  var sets: [ExerciseSet] = []
  var duration: Float = 0.0

  init() {}

}

enum Muscle: String, Codable {
  case chest = "Chest"
  case back = "Back"
  case biceps = "Biceps"
  case triceps = "Triceps"
  case shoulders = "Shoulders"


  case legs = "Legs"
}

struct SeedWorkoutTemplate: Decodable {
  var title: String
  var exercises: [SeedExercise]
}

struct SeedExercise: Decodable {
  var name: String
  var target: Muscle
}
