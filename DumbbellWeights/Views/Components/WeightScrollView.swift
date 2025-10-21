//
//  WeightScrollView.swift
//  DumbbellWeights
//
//  Created by Didier on 9/13/25.
//

import SwiftUI
import SwiftData

struct WeightScrollView: View {
  var items: [Int]
  @Binding var selectedItem: Int

  @State private var scrollCenter: Double = 0
  @State private var isScrolling: Bool = false

  @Query private var lastSet: [ExerciseSet]

  let onWeightPress: (_:Int) -> Void

  func onScroll(_ changedValue: Int, newValue: CGRect) -> Void {
    let topBound = newValue.origin.y
    let bottomBound = newValue.origin.y + newValue.height
    let isCenter = scrollCenter > topBound && scrollCenter < bottomBound
    if (isCenter) {
      selectedItem = changedValue
    }
  }

  func onCenterChange(newCenter: Double) -> Void {
    scrollCenter = newCenter
  }

  init(
    currentExercise: Exercise?,
    selectedItem: Binding<Int>,
    onWeightPress: @escaping (_: Int) -> Void
  ) {
    self.items = allWeights
    self._selectedItem = selectedItem
    self.onWeightPress = onWeightPress
    if let currentExercise = currentExercise {
      let currName = currentExercise.name

      _lastSet = Query(
        filter: #Predicate<ExerciseSet> {
          $0.exercise.name == currName
        },
        sort: \ExerciseSet.date,
        order: .reverse,
      )
    }
  }

  var body: some View {
    CenteredScrollView(onCenterChange: onCenterChange, initialItem: $selectedItem, isScrolling: $isScrolling) {
      LazyVStack {
        Spacer(minLength: 64 * 3)

        ForEach(items, id: \.self) { weight in
          WeightButton(title: String(weight), primary: weight == selectedItem) {
            onWeightPress(weight)
          }
          .padding(6)
          .background {
            ItemGeometryReader() { newValue in
              if isScrolling {
                onScroll(weight, newValue: newValue)
              }
            }
          }
        }

        Spacer(minLength: 64 * 3)
      }
    }
    .onChange(of: lastSet, { oldValue, newValue in
      guard let lastWeight = newValue.first?.weight else {
        selectedItem = defaultWeight
        return
      }
      selectedItem = lastWeight
    })
    .mask {
      VStack(spacing: 0) {
        LinearGradient(
          colors: [.clear, .black],
          startPoint: .top,
          endPoint: .bottom
        )
        .frame(height: 75)
        Rectangle().fill(Color.black)
        LinearGradient(
          colors: [.clear, .black],
          startPoint: .bottom,
          endPoint: .top
        )
        .frame(height: 75)
      }
    }
  }
}

#Preview {
  BackgroundView {
    WeightScrollView(currentExercise: Exercise("Test 1"), selectedItem: .constant(0), onWeightPress: { _ in })
  }
}
