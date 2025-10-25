//
//  WorkoutService.swift
//  DumbbellWeights
//
//  Created by Didier on 10/2/25.
//

struct WorkoutService {
  func GetExercises() -> [[String]] {
    return [
      ["Dumbbell Bench Press", "Chest"],
      ["Push-Up", "Chest"],
      ["Dumbbell Chest Fly", "Chest"],

      ["Bent-Over Row", "Back"],
      ["Reverse Fly", "Back"],
      ["Superman Hold", "Back"],

      ["Bicep Curl", "Biceps"],
      ["Hammer Curl", "Biceps"],
      ["Concentration Curl", "Biceps"],

      ["Overhead Tricep Extension", "Triceps"],
      ["Tricep Kickback", "Triceps"],
      ["Close-Grip Push-Up", "Triceps"],

      ["Overhead Press", "Shoulders"],
      ["Lateral Raise", "Shoulders"],
      ["Front Raise", "Shoulders"],

      ["Plank", "Core"],
      ["Russian Twist", "Core"],
      ["Leg Raise", "Core"],

      ["Farmer’s Carry", "Forearms"],
      ["Wrist Curl", "Forearms"],
      ["Reverse Curl", "Forearms"],

      ["Squat", "Legs"],
      ["Lunge", "Legs"],
      ["Romanian Deadlift", "Legs"],

      ["Glute Bridge", "Glutes"],
      ["Bulgarian Split Squat", "Glutes"],
      ["Step-Up", "Glutes"],

      ["Standing Calf Raise", "Calves"],
      ["Seated Calf Raise", "Calves"]
    ]
  }
}

