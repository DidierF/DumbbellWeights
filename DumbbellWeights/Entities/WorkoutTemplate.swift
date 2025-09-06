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
