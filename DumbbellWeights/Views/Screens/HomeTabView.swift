//
//  HomeTabView.swift
//  DumbbellWeights
//
//  Created by Didier on 10/5/25.
//

import SwiftUI

struct HomeTabView: View {
  var body: some View {
    TabView {
      Tab("Workout", systemImage: "dumbbell") {
        NavigationStack {
          ExercisesView()
            .navigationTitle("Exercises")
        }
      }

      Tab("Log", systemImage: "calendar") {
        NavigationStack {
          WorkoutsListView()
            .navigationTitle("Log")
        }
      }
    }
    .tint(.primary3)
  }
}

#Preview {
  HomeTabView()
    .modelContainer(DataController.previewContainer)
}
