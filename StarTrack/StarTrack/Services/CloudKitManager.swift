//
//  CloudKitManager.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 18/06/25.
//

import Foundation
import CloudKit

// MARK: - Gestor de CloudKit
class CloudKitManager {
	static let shared = CloudKitManager()
	
	// Define qual base de dados do CloudKit usar.
	// .publicCloudDatabase: todos os utilizadores veem os mesmos dados.
	private let database = CKContainer.default().publicCloudDatabase

	private init() {}
	
	// --- Funções CRUD (Create, Read, Update, Delete) ---

	/// Busca todos os eventos do CloudKit.
	func fetchEvents() async throws -> [ObservableEvent] {
		// Cria uma query que busca todos os registos do tipo "Events".
		// O predicado "true" significa "trazer todos".
		let query = CKQuery(recordType: ObservableEvent.recordType, predicate: NSPredicate(value: true))
		
		// Executa a query na base de dados.
		let (matchResults, _) = try await database.records(matching: query)
		
		// Converte os resultados (que são do tipo CKRecord)
		// para o seu modelo de dados `Event`, ignorando os que possam estar malformados.
		let events = try matchResults.compactMap { _, result in
			let record = try result.get()
			return ObservableEvent(from: record)
		}
		
		return events
	}
}


// MARK: - 3. Exemplo de como usar numa ViewModel (para referência)
// O seu ViewModel iria interagir com este gestor.

@MainActor
class EventViewModel: ObservableObject {
	@Published var cloudKitEvents: [Event] = []
	private let ckManager = CloudKitManager.shared

	func fetchCloudKitData() {
		Task {
			do {
				self.cloudKitEvents = try await ckManager.fetchEvents()
			} catch {
				print("Erro ao buscar eventos do CloudKit: \(error.localizedDescription)")
			}
		}
	}
	
//	func addCloudKitEvent() {
//		Task {
//			let newEvent = Event(name: "Novo Evento da Nuvem")
//			do {
//				try await ckManager.saveEvent(newEvent)
//				// Após guardar com sucesso, adiciona à lista local para a UI atualizar.
//				self.cloudKitEvents.append(newEvent)
//			} catch {
//				print("Erro ao guardar evento no CloudKit: \(error.localizedDescription)")
//			}
//		}
//	}
}

