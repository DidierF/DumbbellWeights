//
//  StartButton.swift
//  DumbbellWeights
//
//  Created by Didier on 10/13/25.
//

import SwiftUI

struct StartButton: View {

  var body: some View {
    if #available(iOS 26, *) {
      Image(systemName: "arrow.right")
        .resizable()
        .scaledToFit()
        .frame(width: 26)
        .frame(width: 44, height: 44)
        .padding(8)
        .tint(.primary3)
        .background(.primary2)
        .glassEffect(.clear)
        .clipShape(
          ConcentricRectangle()
        )
    } else {
      Image(systemName: "arrow.right")
        .resizable()
        .scaledToFit()
        .frame(width: 26)
        .frame(width: 44, height: 44)
        .padding(8)
        .tint(.blue)
        .background(.primary2)
        .clipShape(
          Circle()
        )
    }
  }
}

#Preview {
  BackgroundView {
    NavigationLink {} label: {
      StartButton()
    }
    .containerShape(.rect(cornerRadius: 32))
  }
}
