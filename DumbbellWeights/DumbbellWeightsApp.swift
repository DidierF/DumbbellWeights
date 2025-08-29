//
//  DumbbellWeightsApp.swift
//  DumbbellWeights
//
//  Created by Didier on 8/28/25.
//

import SwiftUI

@main
struct DumbbellWeightsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
