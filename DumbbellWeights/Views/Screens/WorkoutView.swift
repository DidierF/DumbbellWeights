//
//  ContentView.swift
//  DumbbellWeights
//
//  Created by Didier on 8/28/25.
//

import SwiftUI

struct WorkoutView: View {
  // var workout = UpperBodyWorkout()

  @Binding var exercises: [Exercise]

  @State var baseWeight = 35;
  var weightDiff = 5;

  var numberOfSets = 3;
  @State var currentSet = 0;

  @State var chosenWeights: [[Int]] = [];

  @State var visibleWeights: [Int] = [];

  var allWeights = [100, 95, 90, 85, 80, 75, 70, 65, 60, 55, 50, 45, 40, 35, 30, 25, 20, 15, 12, 10, 8, 5, 3, 2, 1, 0]

  @State var currentExercise: Int = 0

  func onWeightPress(_ weight: Int) {
    if (chosenWeights.count <= currentSet) {
      chosenWeights.insert([weight], at: currentSet)
    } else {
      chosenWeights[currentSet].append(weight)
    }
    print(chosenWeights)
  }

  func onNextExercise() {
    if currentExercise >= exercises.count - 1 {
      currentExercise = 0
    } else {
      currentExercise += 1
    }
  }


  var body: some View {
    ZStack {
      Color
        .background
        .ignoresSafeArea(.all)

      VStack {
        Text(exercises[currentExercise].name)
          .font(.system(size: 48))
          .fontWeight(.bold)
          .foregroundStyle(Color.white)
          .padding()

        HStack {
          if chosenWeights.count > currentSet {
            ForEach(chosenWeights[currentSet], id: \.self) { w in
              Text(String(w))
            }
          } else {
            Text(" ")
          }
        }
        .font(.system(size: 24))
        .foregroundStyle(Color.secondaryText)
        .fontWeight(.medium)
        .padding()

        Spacer()

        ChevronButton(.up) {
          baseWeight = min(baseWeight + weightDiff, allWeights.first!);
        }
        
        WeightScrollView(items: allWeights, selectedItem: $baseWeight, onWeightPress: onWeightPress)

        ChevronButton(.down) {
          baseWeight = max(baseWeight - weightDiff, allWeights.last ?? 0);
        }

        Spacer()

        Button(action: onNextExercise) {
          HStack {
            Text("Next Exercise")
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
  WorkoutView(exercises: .constant([Exercise("Chest Press"), Exercise("Rows")]))
}
