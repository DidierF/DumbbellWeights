//
//  GraphView.swift
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

struct GraphView: View {

  @State var currentGraph: GraphType = .max

  @State var datapoints: [[Int]] = []
  @State var topWeight: Int = 0
  @State var minWeight: Int = 0

  @Query(sort: [SortDescriptor(\Exercise.name)]) var exercises: [Exercise]
  @Query var exerciseSets: [ExerciseSet]

  init() {
    UINavigationBar
      .appearance().largeTitleTextAttributes = Helpers.getTitleAttributes()
  }

  private func onExercisePress(_ ex: Exercise) {
    print("\(ex.name) \(ex.sets?.count ?? -1)")
    datapoints = []
    topWeight = 0
    minWeight = 999
    let sets = ex.sets?.sorted(by: { $0.date > $1.date }) ?? []
    for (index, eSet) in sets.enumerated() {
      print(eSet.weight)
      datapoints.append([index, eSet.weight])
      topWeight = max(topWeight, eSet.weight)
      minWeight = min(minWeight, eSet.weight)
    }
  }

  var body: some View {
    BackgroundView {
      VStack {

        HStack {
          ForEach(GraphType.allCases) { type in
            let title = type.rawValue.prefix(1).capitalized + type.rawValue.dropFirst()
            Button {
              currentGraph = type
            } label: {
              Text(title)
                .foregroundStyle(Color.primary1)
            }
            .padding()
            .background(currentGraph == .average ? Color.primary4 : Color.primary8)
            .clipShape(RoundedRectangle(cornerRadius: 12))
          }
        }

        Chart {
          ForEach(Array(datapoints.enumerated()), id: \.offset) { index, point in
            LineMark(x: .value("", point[0]), y: .value("", point[1]))
              .interpolationMethod(.cardinal)
          }
//          LineMark(x: .value("", 6), y: .value("", 5))
//          LineMark(x: .value("", 7), y: .value("", 6))
//          LineMark(x: .value("", 8), y: .value("", 6))
//          LineMark(x: .value("", 9), y: .value("", 7))
//          LineMark(x: .value("", 10), y: .value("", 6))
//          LineMark(x: .value("", 12), y: .value("", 12))
//          LineMark(x: .value("", 14), y: .value("", 15))
//          LineMark(x: .value("", 16), y: .value("", 16))
//          LineMark(x: .value("", 18), y: .value("", 13))
//          LineMark(x: .value("", 20), y: .value("", 18))
        }
        .foregroundStyle(Color.primary1)
        .background(Color.primary9)
        .frame(height: 300)
        .chartYAxisLabel("Weight")
        .chartYScale(domain: [minWeight, topWeight])
        .chartYAxis {
          AxisMarks(values: .automatic(desiredCount: 5))
          AxisMarks {
            AxisValueLabel()
              .foregroundStyle(Color.primary1)

            AxisGridLine()
              .foregroundStyle(Color.primary7)
          }
        }
        .chartXAxis {
          AxisMarks {
            AxisValueLabel()
              .foregroundStyle(Color.primary1)

            AxisGridLine()
              .foregroundStyle(Color.primary7)
          }
        }
//        .animation(.default, value: $datapoints)

        ScrollView {
          LazyVGrid(
            columns: [GridItem(.flexible())]
          ) {
            ForEach(exercises) { ex in

              Button {
                onExercisePress(ex)
              } label: {
                Text(ex.name)
                  .foregroundStyle(Color.primary4)
              }
              .padding()
              .background(Color.primary8)
            }
          }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.red)
      }
//      .padding(.horizontal)
    }
  }
}

#Preview {
  NavigationStack {
    GraphView()
      .modelContainer(DataController.previewContainer)
      .navigationTitle("Progress")
  }
}
