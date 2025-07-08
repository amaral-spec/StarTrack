//
//  EntitiesPopulation.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 02/07/25.
//
import Foundation
import CoreData

// MARK: - 1. Protocolo "Populatable"
protocol PopulatableEntity: NSManagedObject {
	associatedtype DataType: Decodable
	func populate(from data: DataType)
}

// MARK: - 2. Funcoes auxiliares
private func createAndPopulate<Entity: PopulatableEntity>(
	from data: Entity.DataType?,
	in context: NSManagedObjectContext?
) -> Entity? {
	guard let context = context,
		  let data = data
	else { return nil }
	
	let entity = Entity(context: context)
	entity.populate(from: data)
	return entity
}

// MARK: - 3. Entidades populatable

extension AccessibleImageEntity: PopulatableEntity {
	typealias DataType = SeederData.ImageData

	func populate(from data: DataType) {
		self.localImage = data.localImage
		self.alternativeText = data.alternativeText
	}
}

extension FactEntity: PopulatableEntity {
	typealias DataType = SeederData.FactData

	func populate(from data: DataType) {
		self.id = data.id
		self.name = data.name
		self.mascotComment = data.mascotComment
		self.image = createAndPopulate(from: data.image, in: self.managedObjectContext)
	}
}

extension CelestialBodyEntity: PopulatableEntity {
	typealias DataType = SeederData.CelestialBodyData

	func populate(from data: DataType) {
		self.fact = createAndPopulate(from: data.fact, in: self.managedObjectContext)
		self.popularName = data.popularName
		self.type = data.type
		self.historyAndObservation = data.historyAndObservation
		self.exploringAndMissions = data.exploringAndMissions
		
		self.mainInfo = createAndPopulate(from: data.mainInfo, in: self.managedObjectContext)
		self.physicalCharacteristics = createAndPopulate(from: data.physicalCharacteristics, in: self.managedObjectContext)
		self.triviaAndMiths = createAndPopulate(from: data.triviaAndMiths, in: self.managedObjectContext)
	}
}

extension MainInfoCelestialBodyEntity: PopulatableEntity {
	typealias DataType = SeederData.MainInfoData

	func populate(from data: DataType) {
		self.location = data.location
		self.diameter = DecodableMeasurementEntity.create(from: data.diameter, in: self.managedObjectContext)
		self.typeDescriptive = data.typeDescriptive
		self.visibility = createAndPopulate(from: data.visibility, in: self.managedObjectContext)
		self.rotationPeriod = TimePeriodEntity.create(from: data.rotationPeriod, in: self.managedObjectContext)
		self.translationPeriod = TimePeriodEntity.create(from: data.translationPeriod, in: self.managedObjectContext)
	}
}

extension PhysicalCharacteristicsEntity: PopulatableEntity {
	typealias DataType = SeederData.PhysicalCharacteristicsData

	func populate(from data: DataType) {
		self.temperature = data.temperature
		self.atmosphere = data.atmosphere
		self.surface = data.surface
		self.moons = data.moons
		self.mass = DecodableMeasurementEntity.create(from: data.mass, in: self.managedObjectContext)
		self.atmPressure = DecodableMeasurementEntity.create(from: data.atmPressure, in: self.managedObjectContext)
		self.gravity = DecodableMeasurementEntity.create(from: data.gravity, in: self.managedObjectContext)
		self.density = DecodableMeasurementEntity.create(from: data.density, in: self.managedObjectContext)
	}
}

extension VisibilityEntity: PopulatableEntity {
	typealias DataType = SeederData.VisibilityData

	func populate(from data: DataType) {
		self.viewingMethod = data.viewingMethod
		self.observationZone = data.observationZone
		self.instructions = data.instructions
	}
}

extension KnowledgeBuildEntity: PopulatableEntity {
	typealias DataType = SeederData.TriviaAndMithsData

	func populate(from data: DataType) {
		self.culturalParallels = data.culturalParallels
		self.trivia = data.trivia
	}
}

extension HistoricalCosmicEventEntity: PopulatableEntity {
	typealias DataType = SeederData.HistoricalCosmicEventData

	func populate(from data: DataType) {
		self.fact = createAndPopulate(from: data.fact, in: self.managedObjectContext)
		self.culturalParallels = data.culturalParallels
		self.explanation = data.explanation
		self.evidence = data.evidence
		self.type = data.type
		self.timePeriod = TimePeriodEntity.create(from: data.timePeriod, in: self.managedObjectContext)
	}
}

extension SpaceMissionEntity: PopulatableEntity {
	typealias DataType = SeederData.SpaceMissionData

	func populate(from data: DataType) {
		self.fact = createAndPopulate(from: data.fact, in: self.managedObjectContext)
		self.launchLocation = data.launchLocation
		self.missionType = data.missionType
		self.objectives = data.objectives
		self.techEnvolved = data.techEnvolved
		self.results = data.results
		self.highlights = data.highlights
		self.distanceTraveled = DecodableMeasurementEntity.create(from: data.distanceTraveled, in: self.managedObjectContext)
		self.date = createAndPopulate(from: data.date, in: self.managedObjectContext)
	}
}

extension DateTimeEntity: PopulatableEntity {
	typealias DataType = SeederData.DateTimeData

	func populate(from data: DataType) {
		self.startAt = data.startAt
		self.duration = data.duration
	}
}

extension ObservatoryEntity: PopulatableEntity {
	typealias DataType = SeederData.ObservatoryData

	func populate(from data: DataType) {
		self.fact = createAndPopulate(from: data.fact, in: self.managedObjectContext)
		self.city = data.city
		self.state = data.state
		self.cientificHighlights = data.cientificHighlight
		self.technologiesAvailable = data.technologiesAvailable
		self.gpsLocation = createAndPopulate(from: data.gpsLocation, in: self.managedObjectContext)
		self.visitation = createAndPopulate(from: data.visitation, in: self.managedObjectContext)
	}
}

extension GPSLocationEntity: PopulatableEntity {
	typealias DataType = SeederData.GPSLocationData

	func populate(from data: DataType) {
		self.latitude = data.latitude
		self.longitude = data.longitude
	}
}

extension VisitationEntity: PopulatableEntity {
	typealias DataType = SeederData.VisitationData

	func populate(from data: DataType) {
		self.openToPublic = data.openToPublic
		self.tickets = data.tickets
		self.activities = data.activities
	}
}

extension ObservableEventEntity: PopulatableEntity {
	typealias DataType = SeederData.ObservableEventData

	func populate(from data: DataType) {
		self.fact = createAndPopulate(from: data.fact, in: self.managedObjectContext)
		self.type = data.type
		self.explanation = data.explanation
		self.date = createAndPopulate(from: data.date, in: self.managedObjectContext)
		self.visibility = createAndPopulate(from: data.visibility, in: self.managedObjectContext)
	}
}

//MARK: - Entidades não populatable

extension DecodableMeasurementEntity {
	@discardableResult
	static func create<Unit: Dimension>(
			from data: SeederData.DecodableMeasurement<Unit>?,
			in context: NSManagedObjectContext?
		) -> DecodableMeasurementEntity? {
			
			guard let context = context,
				  let value = data?.value,
				  let unitSymbol = data?.unitSymbol
			else { return nil }
			
			let entity = DecodableMeasurementEntity(context: context)
			entity.value = value
			entity.unit = unitSymbol
			return entity
		}
}

extension TimePeriodEntity {
	@discardableResult
	static func create(
		from data: SeederData.TimePeriodData?,
		in context: NSManagedObjectContext?
	) -> TimePeriodEntity? {
		
		guard let context = context,
			  let value = data?.value,
			  let unit = data?.unit
		else { return nil }
		
		let entity = TimePeriodEntity(context: context)
		entity.value = value
		entity.unit = unit
		return entity
	}
}
