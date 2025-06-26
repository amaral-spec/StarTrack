//
//  ModelsInitializers.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 26/06/25.
//

import Foundation
import CoreData
import SwiftUI

extension Fact {
	init?(from entity: FactEntity) {
		guard let id = entity.id,
			  let name = entity.name,
			  let imageEntity = entity.image,
			  let image = AccessibleImage(from: imageEntity)
		else { return nil }
		
		self.id = id
		self.name = name
		self.image = image
		self.mascotComment = entity.mascotComment
	}
}

extension AccessibleImage {
	init?(from entity: AccessibleImageEntity) {
		guard let alternativeText = entity.alternativeText,
			  let localImage = entity.localImage
		else { return nil }
		
		self.alternativeText = alternativeText
		self.localImage = localImage
		self.cloudImage = nil
	}
}

extension DateTime {
	init?(from entity: DateTimeEntity) {
		guard let startAt = entity.startAt else { return nil }
		
		self.init(startAt: startAt, duration: entity.duration)
	}
}

extension TimePeriod {
	init?(from entity: TimePeriodEntity) {
		guard let unitRawValue = entity.unit,
			  let unit = TimeUnit(rawValue: unitRawValue)
		else { return nil }
		
		self.value = entity.value
		self.unit = unit
	}
}

extension VisibilityInfo {
	init?(from entity: VisibilityEntity) {
		guard let viewRawType = entity.viewingMethod,
			  let viewingMethod = ViewingMethod.init(rawValue: viewRawType),
			  let observationZone = entity.observationZone,
			  let instructions = entity.instructions
		else { return nil }
		
		self.viewingMethod = viewingMethod
		self.observationZone = observationZone
		self.instructions = FuncLib.shared.splitString(fromString: instructions, by: "\n")
	}
}

extension Visitation {
	init?(from entity: VisitationEntity) {
		guard let openToPublic = entity.openToPublic,
			  let tickets = entity.tickets,
			  let activities = entity.activities
		else { return nil }
		
		self.openToPublic = openToPublic
		self.tickets = FuncLib.shared.splitString(fromString: tickets, by: "\n")
		self.activities = activities
	}
}

extension Observatory {
	init?(from entity: ObservatoryEntity) {
		guard let factEntity = entity.fact,
			  let fact = Fact(from: factEntity),
			  let location = entity.location,
			  let visitationEntity = entity.visitation,
			  let visitation = Visitation(from: visitationEntity),
			  let cientificHighlights = entity.cientificHighlight,
			  let tech = entity.technologiesAvailable
		else { return nil }
		
		self.fact = fact
		self.location = location
		self.visitation = visitation
		self.cientificHighlight = FuncLib.shared.splitString(fromString: cientificHighlights, by: "\n")
		self.technologiesAvailable = FuncLib.shared.splitString(fromString: tech, by: "\n")
	}
}

extension HistoricalCosmicEvent {
	init?(from entity: HistoricalCosmicEventEntity) {
		guard let factEntity = entity.fact,
			  let fact = Fact(from: factEntity),
			  let culturalParallels = entity.culturalParallels,
			  let explanation = entity.explanation,
			  let evidence = entity.evidence,
			  let timePeriodEntity = entity.timePeriod,
			  let timePeriod = TimePeriod(from: timePeriodEntity),
			  let typeRawValue = entity.type,
			  let type = CosmologicalEventType(rawValue: typeRawValue)
		else { return nil }
		
		self.fact = fact
		self.culturalParallels = FuncLib.shared.splitString(fromString: culturalParallels, by: "\n")
		self.explanation = FuncLib.shared.splitString(fromString: explanation, by: "\n")
		self.evidence = FuncLib.shared.splitString(fromString: evidence, by: "\n")
		self.timePeriod = timePeriod
		self.type = type
	}
}

extension DecodableMeasurement {
	init?(from entity: DecodableMeasurementEntity) {
		guard let unit = entity.unit else { return nil }
		
		self.value = entity.value
		self.unitSymbol = unit
	}
}

extension SpaceMission {
	init?(from entity: SpaceMissionEntity) {
		guard let factEntity = entity.fact,
			  let fact = Fact(from: factEntity),
			  let launchLocation = entity.launchLocation,
			  let missionType = entity.missionType,
			  let distanceTraveled = FuncLib.shared.measurementBuild(
				value: entity.distanceTraveled?.value,
				unitSymbol: entity.distanceTraveled?.unit,
				as: UnitLength.self),
			  let dateEntity = entity.date,
			  let date = DateTime(from: dateEntity),
			  let objectives = entity.objectives,
			  let results = entity.results,
			  let highlights = entity.highlights,
			  let tech = entity.techEnvolved
		else { return nil }
		
		self.fact = fact
		self.launchLocation = launchLocation
		self.missionType = missionType
		self.distanceTraveled = distanceTraveled
		self.date = date
		self.objectives = FuncLib.shared.splitString(fromString: objectives, by: "\n")
		self.results = FuncLib.shared.splitString(fromString: results, by: "\n")
		self.highlights = FuncLib.shared.splitString(fromString: highlights, by: "\n")
		self.techEnvolved = FuncLib.shared.splitString(fromString: tech, by: "\n")
	}
}

extension MainInfo {
	init?(from entity: MainInfoCelestialBodyEntity) {
		guard let location = entity.location,
			  let diameter = FuncLib.shared.measurementBuild(
				value: entity.diameter?.value,
				unitSymbol: entity.diameter?.unit,
				as: UnitLength.self),
			  let typeDescriptive = entity.typeDescriptive,
			  let visibilityEntity = entity.visibility,
			  let visibility = VisibilityInfo(from: visibilityEntity),
			  let rotationEntity = entity.rotationPeriod,
			  let rotation = TimePeriod(from: rotationEntity),
			  let translationEntity = entity.translationPeriod,
			  let translation = TimePeriod(from: translationEntity)
		else { return nil }
		
		self.location = location
		self.diameter = diameter
		self.typeDescriptive = typeDescriptive
		self.visibility = visibility
		self.rotationPeriod = rotation
		self.translationPeriod = translation
	}
}

extension PhysicalCharacteristics {
	init?(from entity: PhysicalCharacteristicsEntity) {
		guard let mass = FuncLib.shared.measurementBuild(
			value: entity.mass?.value,
			unitSymbol: entity.mass?.unit,
			as: UnitMass.self),
			  let temperature = entity.temperature,
			  let atmosphere = entity.atmosphere,
			  let atmPressure = FuncLib.shared.measurementBuild(
				value: entity.atmPressure?.value,
				unitSymbol: entity.atmPressure?.unit,
				as: UnitPressure.self),
			  let surface = entity.surface,
			  let gravity = FuncLib.shared.measurementBuild(
				value: entity.gravity?.value,
				unitSymbol: entity.gravity?.unit,
				as: UnitAcceleration.self),
			  let density = FuncLib.shared.measurementBuild(
				value: entity.density?.value,
				unitSymbol: entity.density?.unit,
				as: UnitConcentrationMass.self),
			  let moons = entity.moons
		else { return nil }
		
		self.mass = mass
		self.temperature = temperature
		self.atmosphere = atmosphere
		self.atmPressure = atmPressure
		self.surface = surface
		self.gravity = gravity
		self.density = density
		self.moons = moons
	}
}

extension KnowledgeBuild {
	init?(from entity: KnowledgeBuildEntity) {
		guard let culturalParallels = entity.culturalParallels,
			  let trivia = entity.trivia
		else { return nil }
		
		self.culturalParallels = FuncLib.shared.splitString(fromString: culturalParallels, by: "\n")
		self.trivia = FuncLib.shared.splitString(fromString: trivia, by: "\n")
	}
}

extension CelestialBody {
	init?(from entity: CelestialBodyEntity) {
		guard let factEntity = entity.fact,
			  let fact = Fact(from: factEntity),
			  let popularName = entity.popularName,
			  let typeRawValue = entity.type,
			  let type = CelestialBodyType(rawValue: typeRawValue),
			  let mainInfoEntity = entity.mainInfo,
			  let mainInfo = MainInfo(from: mainInfoEntity),
			  let physicalCharEntity = entity.physicalCharacteristics,
			  let physicalChar = PhysicalCharacteristics(from: physicalCharEntity),
			  let historyAndObservation = entity.historyAndObservation,
			  let exploringAndMission = entity.exploringAndMissions,
			  let triviaAndMithsEntity = entity.triviaAndMiths,
			  let triviaAndMiths = KnowledgeBuild(from: triviaAndMithsEntity),
			  let learnMore = entity.learnMore
		else { return nil }
		
		self.fact = fact
		self.popularName = popularName
		self.type = type
		self.mainInfo = mainInfo
		self.physicalCharacteristics = physicalChar
		self.historyAndObservation = FuncLib.shared.splitString(fromString: historyAndObservation, by: "\n")
		self.exploringAndMissions = FuncLib.shared.splitString(fromString: exploringAndMission, by: "\n")
		self.triviaAndMiths = triviaAndMiths
		self.learnMore = FuncLib.shared.splitString(fromString: learnMore, by: "\n")
	}
}
