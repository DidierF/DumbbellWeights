//
//  WorkoutService.swift
//  DumbbellWeights
//
//  Created by Didier on 10/2/25.
//

struct WorkoutService {
  func GetExercises() -> [[String]] {
    return [
      ["Chest Press", "Chest"],
      ["Bent Over Rows", "Back"],
      ["Biceps Curl", "Biceps"],
      ["Triceps Extension", "Triceps"],
      ["Military Press", "Shoulders"],
      ["Bent Over Flies", "Shoulders"],
      ["Bulgarian Split Squat", "Legs"],
      ["Goblet Squat", "Legs"],
      ["Calf Raises", "Legs"],
      ["Romanian Deadlift", "Legs"],
    ]
  }
}

