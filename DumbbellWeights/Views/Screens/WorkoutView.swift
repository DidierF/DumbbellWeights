//
//  ContentView.swift
//  DumbbellWeights
//
//  Created by Didier on 8/28/25.
//

import SwiftUI


let allWeights = [100, 95, 90, 85, 80, 75, 70, 65, 60, 55, 50, 45, 40, 35, 30, 25, 20, 15, 12, 10, 8, 5, 3, 2, 1, 0]

struct WorkoutView: View {
  @Environment(\.modelContext) var context
  @Environment(\.dismiss) var dismiss

  @Binding var exercises: [Exercise]
  @Bindable var workout: Workout
  @State var baseWeight = 35

  let numberOfSets = 3

  @State var chosenWeights: [String: [Int]]
  @State var currentIdx: Int = 0
  @State var currentSet: Int = 0

  init(exercises: Binding<[Exercise]>, workout: Workout) {
    self._exercises = exercises
    self.workout = workout

    var initialWeights: [String: [Int]] = [:]
    for ex in exercises {
      initialWeights[ex.name.wrappedValue] = Array(
        repeating: -1,
        count: numberOfSets
      )
    }
    _chosenWeights = State(initialValue: initialWeights)
  }

  func onWeightPress(_ weight: Int) {
    guard let exercise = currentExercise,
          let exName = currentExercise?.name
    else {
      return
    }

    if currentSet < numberOfSets {
      chosenWeights[exName]?[currentSet] = weight
    } else {
      chosenWeights[exName]?.append(weight)
    }

    let set = ExerciseSet(exercise: exercise, weight: baseWeight)

    context.insert(set)
    workout.sets.append(set)

    if currentIdx >= exercises.count - 1 {
      currentIdx = 0
      currentSet += 1
    } else {
      currentIdx += 1
    }
  }

  func onNextSet() {
    dismiss()
  }

  var currentExercise: Exercise? {
    get {
      guard exercises.count > 0 else {
        return nil
      }
      return exercises[currentIdx]
    }
  }

  var setLog: String {
    get {
      guard let name = currentExercise?.name,
            let currentWeights = chosenWeights[name]
      else {
        return " "
      }
      let initialRes = currentWeights.reduce("") { partialResult, value in
        "\(partialResult) \(value == -1 ? "--" : "\(value)")"
      }
      return (initialRes).trimmingCharacters(in: .whitespaces)
    }
  }


  var body: some View {
    BackgroundView {
      VStack {
        Text(currentExercise?.name ?? " ")
          .font(.system(size: 32, weight: .bold, design: .rounded))
          .foregroundStyle(Color.white)
          .padding()


        Text(setLog)
          .font(.system(size: 24, weight: .medium, design: .rounded))
          .foregroundStyle(Color.secondaryText)
          .padding()

        Spacer()

        ChevronButton(.up) {}

        WeightScrollView(items: allWeights, selectedItem: $baseWeight, onWeightPress: onWeightPress)

        ChevronButton(.down) {}

        Spacer()

        Button(action: onNextSet) {
          HStack {
            Text("Finish Set")
              .font(.system(size: 24))
              .fontWeight(.bold)
              .foregroundStyle(Color.primary2)

            Image(systemName: "chevron.right")
              .resizable()
              .scaledToFit()
              .tint(.primary2)
              .frame(width: 18, height: 18)
          }
        }
        .padding()
      }
    }
  }
}

#Preview {
  WorkoutView(
    exercises: .constant([Exercise("Chest Press"), Exercise("Rows")]),
    workout: Workout()
  )
}
