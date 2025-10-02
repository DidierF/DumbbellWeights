//
//  WeightButton.swift
//  DumbbellWeights
//
//  Created by Didier on 8/31/25.
//

import SwiftUI

struct WeightButton: View {
  var title: String
  var primary = false
  var action: () -> Void

  var body: some View {
    Button(title, action: action)
      .font(.system(size: primary ? 40 : 32))
      .fontWeight(.bold)
      .padding()
      .foregroundStyle(Color.black)
      .frame(width: primary ? 187 : 135, height: primary ? 88 : 64)
      .background(primary ? Color.primary1 : Color.primary2)
      .cornerRadius(8)
      .id(title)
      .animation(.default, value: primary)
  }
}

#Preview {
  struct Preview: View {
    var title = "35"

    var body: some View {
      WeightButton(title: String(40), action: {})
      WeightButton(title: title, primary: true, action: {})
      WeightButton(title: String(30), action: {})
    }
  }
  return Preview()
}
