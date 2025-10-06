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

  var numberOfSets = 3

  @State var chosenWeights: [String: [Int]]
  @State var currentIdx: Int = 0

  init(exercises: Binding<[Exercise]>, workout: Workout) {
    self._exercises = exercises
    self.workout = workout

    var initialWeights: [String: [Int]] = [:]
    for ex in exercises {
      initialWeights[ex.name.wrappedValue] = []
    }
    _chosenWeights = State(initialValue: initialWeights)
  }

  func onWeightPress(_ weight: Int) {
    guard let exName = currentExercise?.name else {
      return
    }
    chosenWeights[exName]?.append(weight)

    let set = ExerciseSet(exercise: currentExercise!, weight: baseWeight)

    context.insert(set)
    workout.sets.append(set)

    if currentIdx >= exercises.count - 1 {
      currentIdx = 0
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
      guard let name = currentExercise?.name else {
        return " "
      }
      return chosenWeights[name]?.reduce("") { partialResult, value in
        "\(partialResult ?? "") \(value)"
      } ?? " "
    }
  }


  var body: some View {
    BackgroundView {
      VStack {
        Text(currentExercise?.name ?? " ")
          .font(.system(size: 32))
          .fontWeight(.bold)
          .foregroundStyle(Color.white)
          .padding()


        Text(setLog)
          .font(.system(size: 24))
          .foregroundStyle(Color.secondaryText)
          .fontWeight(.medium)
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

//#Preview {
//  WorkoutView(exercises: .constant([Exercise("Chest Press"), Exercise("Rows")]), workout: .constant(Workout()))
//}
