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

  var body: some View {
    Button(action: action) {
      Text(title)
        .font(.system(size: 24))
        .fontWeight(isSelected ? .bold : .medium)
        .padding()
    }
    .frame(minWidth: 300, minHeight: 75)
    .background(isSelected ? .primary2 : .clear)
    .foregroundStyle(.white)
    .clipShape(
      RoundedRectangle(cornerSize: .init(width: radius, height: radius))
    )
    .overlay(
      RoundedRectangle(cornerSize: .init(width: radius, height: radius))
        .stroke(isSelected ? .primary2 : .white, lineWidth: 2.0)
    )
    .padding()
    .animation(.default, value: isSelected)
  }
}

#Preview {
  VStack {
    ExerciseButton(title: "test1", isSelected: true, action: {})
    ExerciseButton(title: "test1", isSelected: false, action: {})
  }
  .background(Color.background)
}
