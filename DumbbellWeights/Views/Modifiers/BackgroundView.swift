//
//  BackgroundView.swift
//  DumbbellWeights
//
//  Created by Didier on 10/5/25.
//

import SwiftUI

struct BackgroundView<Content: View>: View {
  let content: Content

  init(@ViewBuilder _ content: () -> Content) {
    self.content = content()
  }

  var body: some View {
    ZStack {
      Color
        .background
        .ignoresSafeArea(.all)

      content
    }
  }
}

#Preview {
  BackgroundView {
    Text("Test")
  }
}
