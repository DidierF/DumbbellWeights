//
//  ExercisesView.swift
//  DumbbellWeights
//
//  Created by Didier on 10/1/25.
//

import SwiftUI
import SwiftData

struct ExercisesView: View {
  static let startOfToday = Calendar.current.startOfDay(for: Date())
  static let startOfTomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Calendar.current.startOfDay(for: Date()))!

  @Environment(\.modelContext) private var context

  @Query(sort: [SortDescriptor(\Exercise.name)]) var exercises: [Exercise]

  @Query(filter: #Predicate<Workout> { $0.date >= startOfToday && $0.date < startOfTomorrow })
  var workouts: [Workout]

  @State var selected: [Exercise] = []

  init() {
    UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]

    UINavigationBar.appearance().barTintColor = UIColor.background
    UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
  }

  var body: some View {
    BackgroundView {
      ScrollView() {
        VStack {
          ForEach(exercises, id: \.id) { ex in
            let isSelected = selected.contains(ex)
            ExerciseButton(
              title: ex.name,
              isSelected: isSelected) {
                if isSelected {
                  selected.remove(at: selected.firstIndex(of: ex)!)
                } else {
                  selected.append(ex)
                }
              }
          }
        }
      }
      .scrollIndicators(.hidden)
    }
    .overlay(alignment: .bottomTrailing) {
      NavigationLink {
        if let workout = workouts.first {
          WorkoutView(exercises: $selected, workout: workout)
            .navigationBarBackButtonHidden()
            .toolbarVisibility(.hidden, for: .tabBar)
        }
      } label: {
        Image(systemName: "arrow.right")
          .resizable()
          .scaledToFit()
          .frame(width: 26)
          .frame(width: 44, height: 44)
          .padding(8)
          .tint(.white)
          .background(.primary2)
          .clipShape(
            Circle()
          )
          .padding(.init(top: 0, leading: 0, bottom: 8, trailing: 16))
      }
      .disabled(selected.isEmpty || workouts.isEmpty)
    }
    .onAppear {
      selected = []
    }
    .task {
      if workouts.isEmpty {
        let initWorkout = Workout()
        context.insert(initWorkout)
      }
    }
  }
}

#Preview {
  ExercisesView()
    .modelContainer(DataController.previewContainer)
}
