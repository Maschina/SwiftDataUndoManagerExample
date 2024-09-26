//
//  SwiftDataUndoManagerExampleApp.swift
//  SwiftDataUndoManagerExample
//
//  Created by Robert Hahn on 19.09.24.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataUndoManagerExampleApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            ParentItem.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
