//
//  InformesApp.swift
//  Informes
//
//  Created by Jesus Lopez on 27/3/25.
//

import SwiftUI

@main
struct InformesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
