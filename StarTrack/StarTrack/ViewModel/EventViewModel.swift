//
//  EventViewModel.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 16/06/25.
//

import SwiftUI

class EventViewModel: ObservableObject {
	@Published var events: [Event] = []
	@Published var isLoading = false
	
	private let api = SupabaseManager.shared

	func fetch() {
		// Usa Task para rodar o código assíncrono.
		Task {
			isLoading = true
			do {
				self.events = try await api.fetchEvents()
			} catch {
				print("❌ Erro ao buscar eventos: \(error.localizedDescription)")
			}
			isLoading = false
		}
	}
	
	func add() {
		Task {
			let randomNum = Int.random(in: 1...1000)
			let newEventData = SupabaseManager.NewEvent(
				name: "Evento de Teste #\(randomNum)",
				description: "Esta é uma descrição gerada automaticamente.",
				startAt: Date(), // Começa agora
				observeInstructions: "Olhe para o céu."
			)
			
			do {
				let createdEvent = try await api.addEvent(newEvent: newEventData)
				events.append(createdEvent)
			} catch {
				print("❌ Erro ao adicionar evento: \(error.localizedDescription)")
			}
		}
	}
	
	// Deleta com o gesto de "deslizar para apagar" de uma List no SwiftUI
	func delete(at offsets: IndexSet) {
		let eventsToDelete = offsets.map { events[$0] }
		
		for event in eventsToDelete {
			Task {
				do {
					try await api.deleteEvent(id: event.id)
					events.removeAll { $0.id == event.id }
				} catch {
					print("❌ Erro ao deletar evento com id \(event.id): \(error.localizedDescription)")
				}
			}
		}
	}
}
