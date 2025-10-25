//
//  WorkoutsListScreen.swift
//  DumbbellWeights
//
//  Created by Didier on 10/5/25.
//

import SwiftUI
import SwiftData

struct WorkoutsListScreen: View {
  @Environment(\.modelContext) private var modelContext

  @Query(sort: [SortDescriptor(\Workout.date, order: .reverse)]) var workouts: [Workout]

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

  func deleteWorkout(at indexSet: IndexSet) {
    for index in indexSet {
      modelContext.delete(workouts[index])
    }
    try? modelContext.save()
  }

  var body: some View {
    BackgroundView {
      List {
        ForEach(workouts) { workout in
          Section {
            Text(workout.date.formatted())
              .font(.system(size: 20, weight: .medium, design: .rounded))
              .frame(maxWidth: .infinity, alignment: .leading)

            let sets = formatSets(workout.sets)
            ForEach(Array(sets.keys.sorted()), id: \.self) {key in
              SetRow(title: key, weights: sets[key] ?? [])
                .frame(maxWidth: .infinity, alignment: .leading)
            }
          }
          .listRowBackground(Color.primary9)
          .listSectionSeparator(.hidden)
          .listRowSeparator(.hidden)
        }
        .onDelete(perform: deleteWorkout)
        .listSectionSeparator(.hidden)
        .listRowSeparator(.hidden)
        .foregroundStyle(.primary1)
      }
      .listSectionSeparator(.hidden)
      .listRowSeparator(.hidden)
      .scrollContentBackground(.hidden)
      .scrollIndicators(.hidden)
    }
  }
}

struct SetRow: View {
  var title: String
  var weights: [Int]

  var body: some View {
    HStack(alignment: .top) {
      Text("\(title)")
        .font(.system(size: 14, weight: .regular, design: .rounded))
        .padding(.top, 4)
        .frame(width: 100)

      LazyVGrid(columns: [GridItem(.adaptive(minimum: 36))]) {
        ForEach(Array(weights.enumerated()), id: \.offset) { _, aSet in
          Text("\(aSet)")
            .padding(4)
            .frame(alignment: .center)
        }
      }
      .frame(maxWidth: .infinity)
      .background(.primary8)
      .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    .foregroundStyle(.primary1)
  }
}

#Preview {
  //  BackgroundView {
  //    SetRow(title: "test", weights: [2, 2, 2])
  //  }
  NavigationStack {
    WorkoutsListScreen()
      .modelContainer(DataController.previewContainer)
      .navigationTitle("Workouts")
  }
}
