//
//  DumbbellWeightsApp.swift
//  DumbbellWeights
//
//  Created by Didier on 8/28/25.
//

import SwiftUI
import SwiftData

@main
struct DumbbellWeightsApp: App {
  var body: some Scene {
    WindowGroup {
      WorkoutListView()
        .modelContainer(for: [WorkoutTemplate.self, Exercise.self])
        .task {
          await PreloadData()
        }
    }
  }

  @MainActor
  private func PreloadData() async {
    let container = try! ModelContainer(for: WorkoutTemplate.self)
    let context = ModelContext(container)
    let fetchDescriptor = FetchDescriptor<WorkoutTemplate>()

    // Check if we already have data
    let existing = try? context.fetch(fetchDescriptor)
    if let existing, !existing.isEmpty {
      clearData(container: container, models: [WorkoutTemplate.self, Exercise.self])
    }

    print("Creating data")

    // Load bundled JSON
    guard let url = Bundle.main.url(forResource: "SeedData", withExtension: "json"),
          let data = try? Data(contentsOf: url),
          let workouts = try? JSONDecoder().decode([SeedWorkoutTemplate].self, from: data) else {
            print("❌ Failed to load seed data")
            return
          }

    // Insert into SwiftData
    for workoutData in workouts {
      let workout = WorkoutTemplate(workoutData.title)
      let exercises = workoutData.exercises.map { Exercise($0.name, target: $0.target) }
      workout.exercises = exercises
      context.insert(workout)
    }

    try? context.save()
    print("✅ Preloaded \(workouts.count) categories with items")
  }

  @MainActor
  private func clearData(container: ModelContainer, models: [any PersistentModel.Type]) {
    deleteAll(of: WorkoutTemplate.self, in: container)
    deleteAll(of: Exercise.self, in: container)
  }

  @MainActor
  func deleteAll<T: PersistentModel>(of type: T.Type, in container: ModelContainer) {
    let context = ModelContext(container)
    let results = (try? context.fetch(FetchDescriptor<T>())) ?? []
    results.forEach { context.delete($0) }
    try? context.save()
  }
}
