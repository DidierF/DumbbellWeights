//
//  ChevronButton.swift
//  DumbbellWeights
//
//  Created by Didier on 10/3/25.
//

import SwiftUI

enum Direction: String {
  case up = "up"
  case down = "down"
}

struct ChevronButton: View {
  var direction: Direction
  var action: () -> Void

  private var arrowsSize = 36.0

  init(_ direction: Direction, action: @escaping () -> Void) {
    self.direction = direction
    self.action = action
  }

  var body: some View {
    Button(action: action) {
      Image(systemName: "chevron.\(direction)")
        .resizable()
        .scaledToFit()
        .tint(.primary3)
        .frame(width: arrowsSize, height: arrowsSize)
    }
  }
}

