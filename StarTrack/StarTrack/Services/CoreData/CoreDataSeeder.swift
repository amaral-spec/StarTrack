//
//  CoreDataSeeder.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 23/06/25.
//

import Foundation
import CoreData

// MARK: - Estruturas Intermediárias
enum SeederData {
	struct FactData: Codable, Identifiable {
		let id: UUID
		let name: String
		let image: ImageData
		let mascotComment: String?
	}

	struct ImageData: Codable {
		let localImage: String
		let alternativeText: String?
	}

	struct CelestialBodyData: Codable {
		let fact: FactData
		let popularName: String?
		let type: String // CelestialBodyType.rawValue
		let mainInfo: MainInfoData
		let physicalCharacteristics: PhysicalCharacteristicsData
		let historyAndObservation: String // [String]
		let exploringAndMissions: String? // [String]
		let triviaAndMiths: TriviaAndMithsData
	}

	struct MainInfoData: Codable {
		let location: String
		let diameter: DecodableMeasurement<UnitLength>?
		let typeDescriptive: String
		let visibility: VisibilityData
		let rotationPeriod: TimePeriodData
		let translationPeriod: TimePeriodData
	}

	struct PhysicalCharacteristicsData: Codable {
		let mass: DecodableMeasurement<UnitMass>?
		let temperature: String?
		let atmosphere: String?
		let atmPressure: DecodableMeasurement<UnitPressure>?
		let surface: String?
		let gravity: DecodableMeasurement<UnitAcceleration>?
		let density: DecodableMeasurement<UnitConcentrationMass>?
		let moons: String?
	}

	struct VisibilityData: Codable {
		let viewingMethod: String //ViewingMethod.rawValue
		let observationZone: String
		let instructions: String //[String]
	}

	struct TimePeriodData: Codable {
		let value: Double?
		let unit: String? //TimeUnit.rawValue
	}
	
	struct DateTimeData: Codable {
		let startAt: Date
		let duration: TimeInterval
	}


	struct TriviaAndMithsData: Codable {
		let culturalParallels: String? // [String]
		let trivia: String? // [String]
	}

	struct HistoricalCosmicEventData: Codable {
		let fact: FactData
		let culturalParallels: String // [String]
		let explanation: String // [String]
		let evidence: String // [String]
		let timePeriod: TimePeriodData
		let type: String // CosmologicalEventType.rawValue
	}
	
	struct GPSLocationData: Codable {
		let latitude: Double
		let longitude: Double
	}


	struct SpaceMissionData: Codable {
		let fact: FactData
		let launchLocation: String
		let missionType: String
		let distanceTravaled: DecodableMeasurement<UnitLength>?
		let date: DateTimeData
		let objectives: String? // [String]
		let techEnvolved: String // [String]
		let results: String // [String]
		let highlights: String // [String]
	}
	
	struct VisitationData: Codable {
		let openToPublic: String
		let tickets: String
		let activities: String?
	}
	
	struct ObservatoryData: Codable {
		let fact: FactData
		let city: String
		let state: String
		let gpsLocation: GPSLocationData
		let visitation: VisitationData
		let cientificHighlights: String?
		let technologiesAvailable: String
	}

	
	struct ObservableEventData: Codable{
		let fact: FactData
		let date: DateTimeData
		let type: String
		let explanation: String?
		let visibility: VisibilityData
	}

	
	struct DecodableMeasurement<Unit: Dimension>: Codable {
		let value: Double?
		let unitSymbol: String?
		
		private enum CodingKeys: String, CodingKey {
			case value, unitSymbol = "unit"
		}
		
	}
}

// MARK: - Seeder do Core Data
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
		createAndPopulate(SpaceMissionEntity.self, from: "space_missions.json")
		createAndPopulate(HistoricalCosmicEventEntity.self, from: "historical_events.json")
		createAndPopulate(ObservableEventEntity.self, from: "observable_events.json")
		createAndPopulate(ObservatoryEntity.self, from: "observatories.json")
		
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
