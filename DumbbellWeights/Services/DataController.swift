//
//  DataController.swift
//  DumbbellWeights
//
//  Created by Didier on 10/3/25.
//

import SwiftData

@MainActor
class DataController {
  static let previewContainer: ModelContainer = {
    do {
      let config = ModelConfiguration(isStoredInMemoryOnly: true)
      let container = try ModelContainer(for: Exercise.self, configurations: config)

      for i in 1...9 {
        let ex = Exercise("Exercise \(i)")
        container.mainContext.insert(ex)
      }

      return container
    } catch {
      fatalError("Failed to create model container for previewing: \(error.localizedDescription)")
    }
  }()
}
