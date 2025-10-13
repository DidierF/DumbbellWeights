//
//  ExerciseButton.swift
//  DumbbellWeights
//
//  Created by Didier on 10/3/25.
//

import SwiftUI

struct ExerciseButton: View {
  var title: String
  var isSelected: Bool
  var action: () -> Void

  let radius = 8

  private var clipShapeForCurrentPlatform: some Shape {
    if #available(iOS 26, *) {
      return ConcentricRectangle(corners: .concentric)
    } else {
      return RoundedRectangle(cornerSize: .init(width: radius, height: radius))
    }
  }

  var body: some View {
    Button(action: action) {
      Text(title)
        .font(.system(size: 24, weight: .bold, design: .rounded))
        .padding()
    }
    .frame(height: 130)
    .frame(maxWidth: .infinity, alignment: .center)
    .background(isSelected ? .primary3 : .cardBackground)
    .foregroundStyle(isSelected ? .white : .secondaryText)
    .clipShape(clipShapeForCurrentPlatform)
    .animation(.default, value: isSelected)
  }
}

#Preview {
  ScrollView {
    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), alignment: .leading, spacing: 8) {
      ForEach(1...12, id: \.self) { idx in
        ExerciseButton(
          title: "This is the exercise \(idx)",
          isSelected: idx.isMultiple(of: 2),
          action: {
          })
      }
    }
  }
  .containerShape(.rect(cornerRadius: 32))
  .padding(.vertical, 8)
  .padding(.horizontal, 16)
  .background(Color.background)

}
