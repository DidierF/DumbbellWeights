//
//  ProgressListScreen.swift
//  DumbbellWeights
//
//  Created by Didier on 10/20/25.
//

import SwiftUI
import Charts
import SwiftData

enum GraphType: String, CaseIterable, Identifiable {
  case max = "Max"
  case average = "Average"

  var id: Self { self }
}

struct ProgressListScreen: View {

  @State var currentGraph: GraphType = .max

  @State var datapoints: [[Int]] = []
  @State var topWeight: Int = 0
  @State var minWeight: Int = 0

  @Query(sort: [SortDescriptor(\Exercise.name)]) var exercises: [Exercise]
  @Query var exerciseSets: [ExerciseSet]

  @State var selectedExercise: Exercise?

  init() {
    UINavigationBar
      .appearance().largeTitleTextAttributes = Helpers.getTitleAttributes()
  }

  private func onExercisePress(_ ex: Exercise) {
    datapoints = []
    topWeight = 0
    minWeight = 999
    selectedExercise = ex

    let sets = ex.sets?.sorted(by: { $0.date < $1.date }) ?? []
    for (index, eSet) in sets.enumerated() {
      datapoints.append([index, eSet.weight])
      topWeight = max(topWeight, eSet.weight)
      minWeight = min(minWeight, eSet.weight)
    }
  }

  var body: some View {
    BackgroundView {
      List(exercises) { ex in
        NavigationLink {
          ProgressDetailScreen(ex)
            .navigationTitle(ex.name)
        } label: {
          HStack {
            VStack {
              Text(ex.name)
                .foregroundStyle(Color.primary1)
                .font(.system(size: 18, weight: .medium, design: .rounded))
              Spacer()
            }

            Spacer()

            WeightChartView(datapoints: ex.sortedSets.suffix(3).map({ $0.weight }))
              .frame(width: 200, height: 100)
              .clipShape(.rect(cornerRadius: 12))
          }
        }
        .navigationLinkIndicatorVisibility(.hidden)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.primary8)
        .clipShape(.rect(cornerRadius: 12))
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
        .listRowInsets(.init(top: 8, leading: 16, bottom: 8, trailing: 16))
      }
      .listStyle(.plain)
      .scrollIndicators(.hidden)
    }
    .trackScreen(Screens.ProgressList.rawValue)
  }
}

#Preview {
  NavigationStack {
    ProgressListScreen()
      .modelContainer(DataController.previewContainer)
      .navigationTitle("Progress")
  }
}
