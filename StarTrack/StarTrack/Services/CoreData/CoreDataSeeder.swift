//
//  CoreDataSeeder.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 23/06/25.
//

import Foundation
import CoreData

// MARK: - O Seeder do Core Data
// Esta classe irá orquestrar a leitura dos JSONs e a população do Core Data.
class CoreDataSeeder {
	
	private let context: NSManagedObjectContext
	
	init(context: NSManagedObjectContext) {
		self.context = context
	}
	
	func seedDatabaseIfNeeded() {
		let defaults = UserDefaults.standard
		guard !defaults.bool(forKey: "isDatabaseSeeded") else {
			print("INFO: A base de dados Core Data já foi populada anteriormente.")
			return
		}
		
		print("INFO: Populando a base de dados Core Data pela primeira vez...")
		
		createAndPopulate(CelestialBodyEntity.self, from: "celestial_bodies.json")
		createAndPopulate(SpaceMissionEntity.self, from: "space_mission.json")
		createAndPopulate(HistoricalCosmicEventEntity.self, from: "historical_cosmic_events.json")
		createAndPopulate(ObservableEventEntity.self, from: "events.json")
		createAndPopulate(ObservatoryEntity.self, from: "observatory.json")
		
		saveContext()
	}
	
	private func createAndPopulate<Entity: PopulatableEntity>(
		_ entityType: Entity.Type,
		from filename: String
	) {
		let dataArray: [Entity.DataType] = load(filename)
		dataArray.forEach { dataItem in
			let entity = Entity(context: context)
			entity.populate(from: dataItem)
		}
	}
	
	// MARK: - Funções Privadas Auxiliares
	
	private func saveContext() {
		do {
			try context.save()
			UserDefaults.standard.set(true, forKey: "isDatabaseSeeded")
			print("SUCCESS: Base de dados Core Data populada e guardada com sucesso.")
		} catch {
			let nsError = error as NSError
			print("ERROR: Falha ao guardar o contexto inicial do Core Data. \(nsError), \(nsError.userInfo)")
		}
	}
	
	private func load<T: Decodable>(_ filename: String) -> T {
		guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
			fatalError("Não foi possível encontrar o ficheiro \(filename) no bundle principal.")
		}
		guard let data = try? Data(contentsOf: file) else {
			fatalError("Não foi possível carregar o ficheiro \(filename) do bundle.")
		}
		do {
			let decoder = JSONDecoder()
			decoder.dateDecodingStrategy = .iso8601
			return try decoder.decode(T.self, from: data)
		} catch {
			fatalError("Não foi possível descodificar o ficheiro \(filename) como \(T.self):\n\(error)")
		}
	}
}
