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
	
	// MARK: - Estruturas Intermediárias
	private struct FactData: Codable {
		let name: String
		let image: ImageData
		let mascotComment: String?
	}
	
	private struct ImageData: Codable {
		let localImage: String
		let alternativeText: String?
	}
	
	private struct CelestialBodyData: Codable {
		let fact: FactData
		let popularName: String?
		let type: String
		let mainInfo: MainInfoData
		let physicalCharacteristics: PhysicalCharacteristicsData
		let historyAndObservation: String?
		let exploringAndMissions: String?
		let triviaAndMiths: TriviaAndMithsData
		let learnMore: String
	}
	
	private struct MainInfoData: Codable {
		let location: String
		let diameter: DecodableMeasurement<UnitLength>
		let typeDescriptive: String
		let visibility: VisibilityData
		let visibilityDescriptive: String
		let rotationPeriod: TimePeriodData
		let translationPeriod: TimePeriodData
	}
	
	private struct PhysicalCharacteristicsData: Codable {
		let mass: DecodableMeasurement<UnitMass>
		let temperature: String
		let atmosphere: String
		let atmPressure: DecodableMeasurement<UnitPressure>
		let surface: String
		let gravity: DecodableMeasurement<UnitAcceleration>
		let density: DecodableMeasurement<UnitConcentrationMass>
		let moons: String
	}
	
	private struct VisibilityData: Codable {
		let viewingMethod: String
		let instructions: String?
	}
	
	private struct TimePeriodData: Codable {
		let value: Double
		let unit: String
	}
	
	private struct TriviaAndMithsData: Codable {
		let culturalParallels: CulturalParallelData
		let trivia: String?
	}
	
	private struct CulturalParallelData: Codable {
		let culture: String
		let interpretation: String
	}
	
	private struct HistoricalCosmicEventData: Codable {
		let fact: FactData
		let culturalParallels: CulturalParallelData
		let explanation: String?
		let evidence: String?
		let timePeriod: TimePeriodData
		let type: String
		let scale: String
	}
	
	private struct SpaceMissionData: Codable {
		let fact: FactData
		let launchLocation: String
		let distanceTravaled: DecodableMeasurement<UnitLength>
		let date: DateTimeData
		let objectives: String?
		let techEnvolved: String?
		let results: String?
		let highlights: String?
	}
	
	private struct DateTimeData: Codable {
		let startAt: Date
		let endAt: Date?
		let duration: String // AQUI DEVE SER INTERVALO DE TEMPO E DEVE INCLUIR LOGICA DE OPCIONAL
	}
	
	private struct ObservatoryData: Codable {
		let fact: FactData
		let location: String
		let visitation: VisitationData
		let cientificHighlights: String?
		let technologiesAvailable: String?
	}
	
	private struct VisitationData: Codable {
		let openToPublic: String
		let tickets: String?
		let activities: String
	}
	
	// MARK: - Inicializador de Contexto
	init(context: NSManagedObjectContext) {
		self.context = context
	}
	
	// MARK: - Leitor de JSON/Populador de CD
	func seedDatabaseIfNeeded() {
		let defaults = UserDefaults.standard
		guard !defaults.bool(forKey: "isDatabaseSeeded") else { return }
		
		print("INFO: Populando a base de dados Core Data pela primeira vez...")
		
		// --- Carrega todos os ficheiros JSON ---
		let bodiesData: [CelestialBodyData] = load("celestial_bodies.json")
		let historicalEventsData: [HistoricalCosmicEventData] = load("historical_cosmic_events.json")
		let spaceMissionData: [SpaceMissionData] = load("space_mission.json")
		let observatoryData: [ObservatoryData] = load("observatory.json")
		
		// A PARTIR DAQUI ESTÁ DESATUALIZADO!!!
		
		// --- Cria dicionários para busca rápida de entidades ---
		let imageEntities = Dictionary(uniqueKeysWithValues: imagesData.map { data -> (UUID, AccessibleImageEntity) in
			let entity = AccessibleImageEntity(context: context)
			entity.id = data.id
			entity.imageName = data.imageName
			entity.alternativeText = data.alternativeText
			return (data.id, entity)
		})
		
		let factEntities = Dictionary(uniqueKeysWithValues: factsData.map { data -> (UUID, FactEntity) in
			let entity = FactEntity(context: context)
			entity.id = data.id
			entity.name = data.name
			entity.mascotComment = data.mascotComment
			if let imageEntity = imageEntities[data.image_id] {
				entity.image = imageEntity
			}
			return (data.id, entity)
		})
		
		// --- Itera e popula as entidades principais ---
		bodiesData.forEach { data in
			let entity = CelestialBodyEntity(context: context)
			entity.id = data.id
			entity.type = data.type.rawValue
			
			// --- Populando os dados de Measurement (Agora muito mais limpo) ---
			// A conversão acontece dentro da propriedade computada .measurement.
			let radius = data.physicalInfo.radius.measurement
			let mass = data.physicalInfo.mass.measurement
			let distanceFromEarth = data.observationalInfo.distanceFromEarth.measurement
			
			entity.radiusValue = radius.value
			entity.radiusUnitSymbol = radius.unit.symbol
			
			entity.massValue = mass.value
			entity.massUnitSymbol = mass.unit.symbol
			
			entity.distanceFromEarthValue = distanceFromEarth.value
			entity.distanceFromEarthUnitSymbol = distanceFromEarth.unit.symbol
			
			if let densityData = data.physicalInfo.density {
				let density = densityData.measurement
				entity.densityValue = density.value
				entity.densityUnitSymbol = density.unit.symbol
			}
			
			// Liga a entidade Fact correspondente
			if let factEntity = factEntities[data.fact_id] {
				entity.fact = factEntity
			}
		}
		
		do {
			try context.save()
			defaults.set(true, forKey: "isDatabaseSeeded")
			print("SUCCESS: Base de dados Core Data populada e guardada com sucesso.")
		} catch {
			print("ERROR: Falha ao guardar o contexto inicial do Core Data. \(error)")
		}
	}
	
	// MARK: - Funções Auxiliares Privadas
	
	// Converte uma string opcional, delimitada por ponto e vírgula, num array de Strings.
	private func parseString(from string: String?) -> [String] {
		// 1. Garante que a string não é nula, senão retorna um array vazio.
		guard let tagsString = string else { return [] }
		
		// 2. Quebra a string e remove espaços em branco de cada substring.
		return tagsString.components(separatedBy: ";").map {
			$0.trimmingCharacters(in: .whitespaces)
		}
	}
	
	// Já não precisa de nenhuma lógica complexa de descodificação de unidades.
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
