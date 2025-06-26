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
		let id: UUID
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
		let learnMore: String?
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
		let culturalParallels: String?
		let trivia: String?
	}
	
	private struct HistoricalCosmicEventData: Codable {
		let fact: FactData
		let culturalParallels: String?
		let explanation: String?
		let evidence: String?
		let timePeriod: TimePeriodData
		let type: String
		let scale: String
	}
	
	private struct SpaceMissionData: Codable {
		let fact: FactData
		let launchLocation: String
		let missionType: String
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
		
		// MARK: - Converte JSON -> CD
		bodiesData.forEach { data in
			let entity = CelestialBodyEntity(context: context)
			
			// --- Carrega fact ---
			entity.fact?.id = data.fact.id
			entity.fact?.name = data.fact.name
				entity.fact?.image?.localImage = data.fact.image.localImage
				entity.fact?.image?.alternativeText = data.fact.image.alternativeText
			entity.fact?.mascotComment = data.fact.mascotComment
			
			// --- Carrega campos soltos ---
			entity.popularName = data.popularName
			entity.type = data.type
			
			// --- Carrega Main Info ---
			entity.mainInfo?.location = data.mainInfo.location
				let diameter = data.mainInfo.diameter.measurement
				entity.mainInfo?.diameter?.value = diameter.value
			entity.mainInfo?.diameter?.unit = diameter.unit.symbol
			entity.mainInfo?.typeDescriptive = data.mainInfo.typeDescriptive
				entity.mainInfo?.visibility?.viewingMethod = data.mainInfo.visibility.viewingMethod
				entity.mainInfo?.visibility?.instructions = data.mainInfo.visibility.instructions
			entity.mainInfo?.visibilityDescriptive = data.mainInfo.visibilityDescriptive
				entity.mainInfo?.rotationPeriod?.value = data.mainInfo.rotationPeriod.value
				entity.mainInfo?.rotationPeriod?.unit = data.mainInfo.rotationPeriod.unit
				entity.mainInfo?.translationPeriod?.value = data.mainInfo.translationPeriod.value
				entity.mainInfo?.translationPeriod?.unit = data.mainInfo.translationPeriod.unit
			
			// --- Carrega PhysicalCharacteristics ---
				let mass = data.physicalCharacteristics.mass.measurement
				entity.physicalCharacteristics?.mass?.value = mass.value
			entity.physicalCharacteristics?.mass?.unit = mass.unit.symbol
			entity.physicalCharacteristics?.temperature = data.physicalCharacteristics.temperature
			entity.physicalCharacteristics?.atmosphere = data.physicalCharacteristics.atmosphere
				let atmPressure = data.physicalCharacteristics.atmPressure.measurement
				entity.physicalCharacteristics?.atmPressure?.value = atmPressure.value
			entity.physicalCharacteristics?.atmPressure?.unit = atmPressure.unit.symbol
			entity.physicalCharacteristics?.surface = data.physicalCharacteristics.surface
				let gravity = data.physicalCharacteristics.gravity.measurement
				entity.physicalCharacteristics?.gravity?.value = gravity.value
			entity.physicalCharacteristics?.gravity?.unit = gravity.unit.symbol
				let density = data.physicalCharacteristics.density.measurement
				entity.physicalCharacteristics?.density?.value = density.value
			entity.physicalCharacteristics?.density?.unit = density.unit.symbol
			entity.physicalCharacteristics?.moons = data.physicalCharacteristics.moons
			
			// --- Carrega TriviaAndMiths ---
			entity.triviaAndMiths?.culturalParallels = data.triviaAndMiths.culturalParallels
			entity.triviaAndMiths?.trivia = data.triviaAndMiths.trivia
		}
		
		historicalEventsData.forEach { data in
			let entity = HistoricalCosmicEventEntity(context: context)
			
			// --- Carrega fact ---
			entity.fact?.id = data.fact.id
			entity.fact?.name = data.fact.name
				entity.fact?.image?.localImage = data.fact.image.localImage
				entity.fact?.image?.alternativeText = data.fact.image.alternativeText
			entity.fact?.mascotComment = data.fact.mascotComment
			
			// --- Carrega CulturalParallels ---
			entity.culturalParallels = data.culturalParallels
			
			// --- Carrega Explanation ---
			entity.explanation = data.explanation
			
			// --- Carrega Evidence ---
			entity.evidence = data.evidence
			
			// --- Carrega TimePeriod ---
			entity.timePeriod?.value = data.timePeriod.value
			entity.timePeriod?.unit = data.timePeriod.unit
			
			// --- Carrega Type ---
			entity.type = data.type
		}
		
		spaceMissionData.forEach { data in
			let entity = SpaceMissionEntity(context: context)
			
			// --- Carrega fact ---
			entity.fact?.id = data.fact.id
			entity.fact?.name = data.fact.name
				entity.fact?.image?.localImage = data.fact.image.localImage
				entity.fact?.image?.alternativeText = data.fact.image.alternativeText
			entity.fact?.mascotComment = data.fact.mascotComment
			
			entity.launchLocation = data.launchLocation
			entity.missionType = data.missionType
				let distanceTraveled = data.distanceTravaled.measurement
				entity.distanceTraveled?.value = distanceTraveled.value
				entity.distanceTraveled?.unit = distanceTraveled.unit.symbol
			
			// ESTA FALTANDO AQUELE CASO DO STARTAT, ENDAT, DURATION
			entity.date?.startAt = data.date.startAt
			
			// --- Carrega strings finais ---
			entity.objectives = data.objectives
			entity.techEnvolved = data.techEnvolved
			entity.results = data.results
			entity.highlights = data.highlights
		}
		
		observatoryData.forEach { data in
			let entity = ObservatoryEntity(context: context)
			
			// --- Carrega fact ---
			entity.fact?.id = data.fact.id
			entity.fact?.name = data.fact.name
				entity.fact?.image?.localImage = data.fact.image.localImage
				entity.fact?.image?.alternativeText = data.fact.image.alternativeText
			entity.fact?.mascotComment = data.fact.mascotComment
			
			// --- Carrega location ---
			entity.location = data.location
			
			// --- Carrega visitation ---
			entity.visitation?.openToPublic = data.visitation.openToPublic
			entity.visitation?.tickets = data.visitation.tickets
			entity.visitation?.activities = data.visitation.activities
			
			// --- Carrega strings finais ---
			entity.cientificHighlight = data.cientificHighlights
			entity.technologiesAvailable = data.technologiesAvailable
		}
		
		// MARK: - Salva o contexto
		do {
			try context.save()
			defaults.set(true, forKey: "isDatabaseSeeded")
			print("SUCCESS: Base de dados Core Data populada e guardada com sucesso.")
		} catch {
			print("ERROR: Falha ao guardar o contexto inicial do Core Data. \(error)")
		}
	}
	
	// MARK: - Funções Auxiliares Privadas
	
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
