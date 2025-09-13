//
//  ContentView.swift
//  DumbbellWeights
//
//  Created by Didier on 8/28/25.
//

import SwiftUI

struct ContentView: View {
  // var workout = UpperBodyWorkout()

  @State var baseWeight = 35;
  var weightDiff = 5;

  var numberOfSets = 3;
  @State var currentSet = 0;

  @State var chosenWeights: [[Int]] = [];

  @State var visibleWeights: [Int] = [];

  @State var allWeights = [100, 95, 90, 85, 80, 75, 70, 65, 60, 55, 50, 45, 40, 35, 30, 25, 20, 15, 12, 10, 8, 5, 3, 2, 1, 0]

  init() {
    chosenWeights = [];
  }

  func onWeightPress(_ weight: Int) {
    if (chosenWeights.count <= currentSet) {
      chosenWeights.insert([weight], at: currentSet)
    } else {
      chosenWeights[currentSet].append(weight)
    }
    print(chosenWeights)
  }


  private var arrowsSize = 36.0

  var body: some View {
    ZStack {
      Color
        .background
        .ignoresSafeArea(.all)

      VStack {
        //        Text(workout.exercises[currentSet].name)
        //          .font(.system(size: 48))
        //          .fontWeight(.bold)
        //          .foregroundStyle(Color.white)
        //          .padding()

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


        Button {
          baseWeight = min(baseWeight + weightDiff, allWeights.first!);
        } label: {
          Image(systemName: "chevron.up")
            .resizable()
            .scaledToFit()
            .tint(.primary3)
            .frame(width: arrowsSize, height: arrowsSize)
        }
        
        WeightScrollView(items: $allWeights, selectedItem: $baseWeight, onWeightPress: onWeightPress)

        Button {
          baseWeight = max(baseWeight - weightDiff, allWeights.last ?? 0);
        } label: {
          Image(systemName: "chevron.down")
            .resizable()
            .scaledToFit()
            .tint(.primary3)
            .frame(width: arrowsSize, height: arrowsSize)
        }

        Spacer()

        Button {
          //          print(workout.exercises.count)
          //          print(currentSet + 1)
          //          if (workout.exercises.count > currentSet + 1) {
          //            currentSet += 1;
          //          }

        } label: {
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
  ContentView()
}
