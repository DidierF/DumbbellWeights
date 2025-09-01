//
//  WeightButton.swift
//  DumbbellWeights
//
//  Created by Didier on 8/31/25.
//

import SwiftUI

struct WeightButton: View {
  var title: String
  var action: () -> Void

  var body: some View {
    Button(title, action: action)
  }
}

#Preview {
  struct Preview: View {
    var title = "Test"

    var body: some View {
      WeightButton(title: title, action: {})
    }
  }
  return Preview()
}
