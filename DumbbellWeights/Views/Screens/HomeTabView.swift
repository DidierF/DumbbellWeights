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

      Tab("History", systemImage: "calendar") {
        NavigationStack {
          WorkoutsListView()
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
