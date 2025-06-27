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
			ContentView() // A sua view principal aqui
				// 2. Injete o 'viewContext' do Core Data no ambiente do SwiftUI.
				// Isto torna-o disponível para todas as suas views.
				.environment(\.managedObjectContext, persistenceController.container.viewContext)
		}
	}
}
