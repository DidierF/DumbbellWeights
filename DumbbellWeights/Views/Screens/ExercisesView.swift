//
//  ExercisesView.swift
//  DumbbellWeights
//
//  Created by Didier on 10/1/25.
//

import SwiftUI
//import UIKit
import SwiftData

struct ExercisesView: View {
  static let startOfToday = Calendar.current.startOfDay(for: Date())
  static let startOfTomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Calendar.current.startOfDay(for: Date()))!

  @Environment(\.modelContext) private var context

  @Query(sort: [SortDescriptor(\Exercise.name)]) var exercises: [Exercise]

  @Query(filter: #Predicate<Workout> { $0.date >= startOfToday && $0.date < startOfTomorrow })
  var workouts: [Workout]

  @State var selected: [Exercise] = []

  let spacing: CGFloat = 12

  private let gridColumns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 2)

  init() {
    var largeTitleFont = UIFont.preferredFont(forTextStyle: .largeTitle)
    let descriptor =
      largeTitleFont
      .fontDescriptor
      .withDesign(.rounded)?
      .withSymbolicTraits(.traitBold
      )
    largeTitleFont = UIFont(
      descriptor: descriptor ?? largeTitleFont.fontDescriptor,
      size: largeTitleFont.pointSize)

    UINavigationBar
      .appearance().largeTitleTextAttributes = [
        .foregroundColor: UIColor.white,
        .font: largeTitleFont
      ]
  }

  var body: some View {
    BackgroundView {
      ScrollView() {
        LazyVGrid(
          columns: gridColumns,
          alignment: .leading,
          spacing: spacing
        ) {
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
        .containerShape(.rect(cornerRadius: 32))
        .padding(.horizontal, 16)
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
        StartButton()
          .padding(.init(top: 0, leading: 0, bottom: 8, trailing: 16))
      }
      .containerShape(.rect(cornerRadius: 32))
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
  NavigationStack {
    ExercisesView()
      .modelContainer(DataController.previewContainer)
      .navigationTitle("Exercises")
  }
}
