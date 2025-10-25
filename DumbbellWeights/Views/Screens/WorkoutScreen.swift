//
//  WorkoutScreen.swift
//  DumbbellWeights
//
//  Created by Didier on 8/28/25.
//

import SwiftUI


let allWeights = [0, 1, 2, 3, 5, 8, 10, 12, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
let defaultWeight = 35

struct WorkoutScreen: View {
  @Environment(\.modelContext) var context
  @Environment(\.dismiss) var dismiss

  @Binding var exercises: [Exercise]
  @Bindable var workout: Workout
  @State var baseWeight = defaultWeight

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

  func onFinishSet() {
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

  var finishColor: Color {
    switch currentSet {
    case 0, 1:
      return .primary6
    case 2:
      return .primary4
    default:
      return .primary2
    }
  }

  var body: some View {
    BackgroundView {
      VStack {
        Text(currentExercise?.name ?? " ")
          .font(.system(size: 32, weight: .bold, design: .rounded))
          .foregroundStyle(Color.primary1)
          .padding()


        Text(setLog)
          .font(.system(size: 24, weight: .medium, design: .rounded))
          .foregroundStyle(.primary2)
          .padding()

        Spacer()

        ChevronButton(.up) {}

        WeightScrollView(
          currentExercise: currentExercise,
          selectedItem: $baseWeight,
          onWeightPress: onWeightPress
        )

        ChevronButton(.down) {}

        Spacer()

        Button(action: onFinishSet) {
          HStack {
            Text("Finish Set")
              .font(.system(size: 24))
              .fontWeight(.bold)
              .foregroundStyle(finishColor)

            Image(systemName: "chevron.right")
              .resizable()
              .scaledToFit()
              .tint(finishColor)
              .frame(width: 18, height: 18)
          }
        }
        .padding()
      }
    }
  }
}

#Preview {
  WorkoutScreen(
    exercises:
        .constant(
          [
            Exercise("Chest Press", muscle: Muscle("Chest")),
            Exercise("Rows", muscle: Muscle("Chest"))
          ]
        ),
    workout: Workout()
  )
}
