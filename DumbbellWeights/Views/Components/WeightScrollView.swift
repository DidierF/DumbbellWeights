//
//  WeightScrollView.swift
//  DumbbellWeights
//
//  Created by Didier on 9/13/25.
//

import SwiftUI

struct WeightScrollView: View {
  var items: [Int]
  @Binding var selectedItem: Int

  @State private var scrollCenter: Double = 0
  @State private var isScrolling: Bool = false

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

  var body: some View {
    CenteredScrollView(onCenterChange: onCenterChange, initialItem: $selectedItem, isScrolling: $isScrolling) {
      LazyVStack {
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
      }
    }
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
