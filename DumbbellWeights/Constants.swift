//
//  Constants.swift
//  DumbbellWeights
//
//  Created by Didier on 10/26/25.
//

enum Screens: String {
  case ExerciseList = "ExerciseList"
  case HomeTab = "HomeTab"
  case ProgressList = "ProgressList"
  case ProgressDetail = "ProgressDetail"
  case Workout = "Workout"
  case WorkoutList = "WorkoutList"
}

enum Events: String {
  case WorksoutStarted = "WorkoutStarted"
  case WorkoutEnded = "WorkoutEnded"
  case WeightLogged = "WeightLogged"
}
