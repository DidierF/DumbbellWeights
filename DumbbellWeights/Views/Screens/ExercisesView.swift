//
//  ExercisesView.swift
//  DumbbellWeights
//
//  Created by Didier on 10/1/25.
//

import SwiftUI
import SwiftData

struct ExercisesView: View {
  @Query(sort: [SortDescriptor(\Exercise.name)]) var exercises: [Exercise]
  @State var selected: [String] = []

  init() {
    UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]

    UINavigationBar.appearance().barTintColor = UIColor.background
    UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
  }

  var body: some View {
    NavigationStack {
      ZStack {
        Color
          .background
          .ignoresSafeArea(.all)

        ScrollView() {
          VStack {
            ForEach(exercises, id: \.id) { ex in
              let isSelected = selected.contains(ex.name)
              ExerciseButton(
                title: ex.name,
                isSelected: isSelected) {
                  if isSelected {
                    selected.remove(at: selected.firstIndex(of: ex.name)!)
                  } else {
                    selected.append(ex.name)
                  }
                  print(selected)
              }
            }
          }
        }
        .scrollIndicators(.hidden)

      }
      .navigationTitle("Exercises")
    }
  }
}

#Preview {
  ExercisesView()
    .modelContainer(DataController.previewContainer)
}
