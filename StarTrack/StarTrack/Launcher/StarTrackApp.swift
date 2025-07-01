//
//  StarTrackApp.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 09/06/25.
//

import SwiftUI

@main
struct StarTrackApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
