//
//  daily_goalsApp.swift
//  Shared
//
//  Created by alex.zarr on 3/16/21.
//

import SwiftUI

@main
struct daily_goalsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
