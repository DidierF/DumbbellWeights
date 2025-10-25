//
//  ProgressDetailScreen.swift
//  DumbbellWeights
//
//  Created by Didier on 10/23/25.
//

import SwiftUI

struct ProgressDetailScreen: View {
  var exercise: Exercise

  init(_ exercise: Exercise) {
    UINavigationBar
      .appearance().largeTitleTextAttributes = Helpers.getTitleAttributes()

    self.exercise = exercise
  }

  var body: some View {
    BackgroundView {
        VStack {
          WeightChartView(
            datapoints: exercise.sortedSets.map({$0.weight}),
            showAxis: true
          )
          .frame(height: 300)

          Spacer()

          List(exercise.sortedSets) {
            Text("\($0.date.formatted()): \($0.weight)")
          }
          .listStyle(.plain)
          .scrollIndicators(.hidden)
        }
    }
    .navigationBarTitleDisplayMode(.inline)
  }
}
