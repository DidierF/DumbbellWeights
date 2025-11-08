//
//  ExercisesListScreen.swift
//  DumbbellWeights
//
//  Created by Didier on 10/1/25.
//

import SwiftUI
import SwiftData
import FirebaseAnalytics

struct ExercisesListScreen: View {
  static let startOfToday = Calendar.current.startOfDay(for: Date())
  static let startOfTomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Calendar.current.startOfDay(for: Date()))!

  @Environment(\.modelContext) private var context

  @Query(sort: [SortDescriptor(\Exercise.name)]) var exercises: [Exercise]
  @Query(sort: [SortDescriptor(\Muscle.name)]) var muscles: [Muscle]

  @Query(filter: #Predicate<Workout> { $0.date >= startOfToday && $0.date < startOfTomorrow })
  var workouts: [Workout]

  @State var selected: [Exercise] = []

  @State var filterMuscle: Muscle?

  let spacing: CGFloat = 12

  private let gridColumns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 2)

  init() {
    UINavigationBar
      .appearance().largeTitleTextAttributes = Helpers.getTitleAttributes()
  }

  var exerciseGrid: some View {
    LazyVGrid(
      columns: gridColumns,
      alignment: .leading,
      spacing: spacing,
    ) {
      ForEach(
        muscles.filter({ $0.id == filterMuscle?.id ?? $0.id }),
        id: \.id
      ) { muscle in
        Section {
          ForEach(muscle.exercises ?? [], id: \.id) { ex in
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
        } header: {
          Text(muscle.name)
            .foregroundStyle(Color.primary4)
            .gridCellColumns(2)
            .font(.system(size: 28, weight: .medium, design: .rounded))
        }
      }
    }
    .containerShape(.rect(cornerRadius: 32))
    .padding(.horizontal, 16)
    .animation(.spring, value: filterMuscle)
  }

  var body: some View {
    BackgroundView {
      ScrollView {
        MuscleFilterView(
          options: muscles,
          selected: filterMuscle) { m in
            if (filterMuscle == m) {
              filterMuscle = nil
            } else {
              filterMuscle = m
            }
          }
          .contentMargins(.horizontal, 16)

        exerciseGrid
      }
      .scrollIndicators(.hidden)
    }
    .overlay(alignment: .bottomTrailing) {
      NavigationLink {
        if let workout = workouts.first {
          WorkoutScreen(exercises: $selected, workout: workout)
            .navigationBarBackButtonHidden()
            .toolbarVisibility(.hidden, for: .tabBar)
        }
      } label: {
        StartButton()
          .padding(.init(top: 0, leading: 0, bottom: 8, trailing: 16))
      }
      .containerShape(.rect(cornerRadius: 32))
      .disabled(selected.isEmpty || workouts.isEmpty)
      .onTapGesture {
        Analytics.logEvent(Events.WorksoutStarted.rawValue, parameters: ["Exercises": $selected.map({ $0.name })])
      }
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
    .trackScreen(Screens.ExerciseList.rawValue)
  }
}

#Preview {
  NavigationStack {
    ExercisesListScreen()
      .modelContainer(DataController.previewContainer)
      .navigationTitle("Exercises")
  }
}
