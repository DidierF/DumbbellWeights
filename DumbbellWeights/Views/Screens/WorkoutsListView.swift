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

  var body: some View {
    BackgroundView {
      ScrollView {
        VStack {
          ForEach(workouts) { workout in
            Section(header:
              Text(workout.date.formatted())
              .padding()
            ) {
              ForEach(workout.sets) { set in
                HStack {
                  Text(set.exercise.name)
                  Text("\(set.weight)")
                }
              }
            }
          }
          .foregroundStyle(.white)
        }
      }
      .scrollIndicators(.hidden)
    }
  }
}

#Preview {
  WorkoutsListView()
}
