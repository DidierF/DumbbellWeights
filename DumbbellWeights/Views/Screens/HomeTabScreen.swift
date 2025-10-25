//
//  HomeTabScreen.swift
//  DumbbellWeights
//
//  Created by Didier on 10/5/25.
//

import SwiftUI

struct HomeTabScreen: View {
  var body: some View {
    TabView {
      Tab("Workout", systemImage: "dumbbell") {
        NavigationStack {
          ExercisesListScreen()
            .navigationTitle("Exercises")
        }
      }

      Tab("Log", systemImage: "calendar") {
        NavigationStack {
          WorkoutsListScreen()
            .navigationTitle("Log")
        }
      }

      Tab("Progress", systemImage: "chart.xyaxis.line") {
        NavigationStack {
          ProgressListScreen()
            .navigationTitle("Progress")
        }
      }
    }
    .tint(.primary3)
  }
}

#Preview {
  HomeTabScreen()
    .modelContainer(DataController.previewContainer)
}
