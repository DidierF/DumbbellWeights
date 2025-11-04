//
//  ScreenTrackingModifier.swift
//  DumbbellWeights
//
//  Created by Didier on 10/26/25.
//

import SwiftUI
import FirebaseAnalytics

struct ScreenTrackingModifier: ViewModifier {
  let screenName: String

  func body(content: Content) -> some View {
    content
      .onAppear {
        Analytics.logEvent(AnalyticsEventScreenView, parameters: [
          AnalyticsParameterScreenName: screenName
        ])
      }
  }
}

extension View {
  func trackScreen(_ name: String) -> some View {
    self.modifier(ScreenTrackingModifier(screenName: name))
  }
}
