//
//  WorkoutsListView.swift
//  DumbbellWeights
//
//  Created by Didier on 10/5/25.
//

import SwiftUI
import SwiftData

struct WorkoutsListView: View {
  @Query(sort: [SortDescriptor(\Workout.date)]) var workouts: [Workout]

  init() {
    UINavigationBar
      .appearance().largeTitleTextAttributes = Helpers.getTitleAttributes()
  }

  func formatSets(_ sets: [ExerciseSet]) -> [String: [Int]] {

    var result: [String: [Int]] = [:]

    for aSet in sets {
      let name = aSet.exercise.name
      if result[name] == nil {
        result[name] = []
      }
      result[name]?.append(aSet.weight)
    }

    return result

  }

  var body: some View {
    BackgroundView {
      ScrollView {
        LazyVStack {
          ForEach(workouts) { workout in
            Section(
              header:
                Text(workout.date.formatted())
                .font(.system(size: 20, weight: .medium, design: .rounded))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.leading, .top])
            ) {
              let sets = formatSets(workout.sets)
              VStack(alignment: .leading) {
                ForEach(Array(sets.keys.sorted()), id: \.self) {key in
                  HStack {
                    Text("\(key)")
                    ForEach(sets[key] ?? [], id: \.self) { aSet in
                      Text("\(aSet)")
                    }
                  }
                  .frame(maxWidth: .infinity, alignment: .leading)
                  .foregroundStyle(.primary1)
                  .padding(.horizontal)
                }
              }
              .frame(maxWidth: .infinity)
            }
          }
          .foregroundStyle(.primary1)
        }
      }
      .scrollIndicators(.hidden)
    }
  }
}

#Preview {
  NavigationStack {
    WorkoutsListView()
      .modelContainer(DataController.previewContainer)
      .navigationTitle("Workouts")
  }
}
