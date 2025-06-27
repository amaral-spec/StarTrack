//
//  CoreDataManager.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 25/06/25.
//

import Foundation
import CoreData

// MARK: - Gestor de Dados do Core Data
// Esta classe é a única que interage diretamente com o Core Data.
class CoreDataManager {
	
	private let context: NSManagedObjectContext
	
	init(context: NSManagedObjectContext) {
		self.context = context
	}
	
	// MARK: - Funções de busca (Fetch)
	func fetchFacts(searchText: String? = nil) -> [Fact] {
		let request = NSFetchRequest<FactEntity>(entityName: "FactEntity")
		
		if let searchText = searchText, !searchText.isEmpty {
			request.predicate = NSPredicate(format: "name CONTAINS[c] %@", searchText)
		}
		
		request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
		
		do {
			let results = try context.fetch(request)
			return results.compactMap { Fact(from: $0) }
		} catch {
			print("Erro ao buscar Facts: \(error)")
			return []
		}
	}
	
	func fetchCelestialBodies(ofType type: CelestialBodyType? = nil, searchText: String? = nil) -> [CelestialBody] {
		let request = NSFetchRequest<CelestialBodyEntity>(entityName: "CelestialBodyEntity")
		
		// --- LÓGICA DE FILTRAGEM ---
		var predicates: [NSPredicate] = []
		
		if let bodyType = type {
			predicates.append(NSPredicate(format: "type == %@", bodyType.rawValue))
		}
		
		if let searchText = searchText, !searchText.isEmpty {
			// "fact.name CONTAINS[c] %@" -> '[c]' torna a busca não case sensetives.
			predicates.append(NSPredicate(format: "fact.name CONTAINS[c] %@", searchText))
		}
		
		// 3. Combina todos os filtros com um "E" lógico.
		if !predicates.isEmpty {
			request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
		}
		
//		let sortDescriptor = NSSortDescriptor(keyPath: \CelestialBodyEntity.fact?.name, ascending: true)
//		request.sortDescriptors = [sortDescriptor]
		
		do {
			let results = try context.fetch(request)
			return results.compactMap { CelestialBody(from: $0) }
		} catch {
			print("Erro ao buscar CelestialBodies: \(error)")
			return []
		}
	}
	
	func fetchHistoricalCosmicEvents() -> [HistoricalCosmicEvent] {
		let request = NSFetchRequest<HistoricalCosmicEventEntity>(entityName: "HistoricalCosmicEventEntity")
		
		do {
			let results = try context.fetch(request)
			return results.compactMap { HistoricalCosmicEvent(from: $0) }
		} catch {
			print("Erro ao buscar HistoricalCosmicEvents: \(error)")
			return []
		}
	}
	
	func fetchSpaceMissions() -> [SpaceMission] {
		let request = NSFetchRequest<SpaceMissionEntity>(entityName: "SpaceMissionEntity")
		
		do {
			let results = try context.fetch(request)
			return results.compactMap { SpaceMission(from: $0) }
		} catch {
			print("Erro ao buscar SpaceMissions: \(error)")
			return []
		}
	}
	
	func fetchObservatories() -> [Observatory] {
		let request = NSFetchRequest<ObservatoryEntity>(entityName: "ObservatoryEntity")
		
		do {
			let results = try context.fetch(request)
			return results.compactMap { Observatory(from: $0) }
		} catch {
			print("Erro ao buscar Observatories: \(error)")
			return []
		}
	}
}
