//
//  ModelsInitializers.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 26/06/25.
//

import CoreData
import SwiftUI
import CoreLocation


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
    }
}

extension DateTime {
    init?(from entity: DateTimeEntity) {
        guard let startAt = entity.startAt else { return nil }
        
        self.init(startAt: startAt, duration: entity.duration)
    }
}

extension TimePeriod {
    init?(from entity: TimePeriodEntity?) {
        guard let entity = entity,
			  let unitRawValue = entity.unit,
              let unit = TimeUnit(rawValue: unitRawValue)
        else { return nil }
        
        self.value = entity.value
        self.unit = unit
    }
}

extension VisibilityInfo {
    init?(from entity: VisibilityEntity) {
        guard let viewRawType = entity.viewingMethod,
              let viewingMethod = ViewingMethod(rawValue: viewRawType),
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
              let tickets = entity.tickets
        else { return nil }
        
        self.openToPublic = openToPublic
        self.tickets = FuncLib.shared.splitString(fromString: tickets, by: "\n")
        self.activities = entity.activities
    }
}

extension Observatory {
    init?(from entity: ObservatoryEntity) {
        guard let factEntity = entity.fact,
              let fact = Fact(from: factEntity),
              let gpsLocation = entity.gpsLocation,
              let city = entity.city,
              let state = entity.state,
              let visitationEntity = entity.visitation,
              let visitation = Visitation(from: visitationEntity),
              let cientificHighlight = entity.cientificHighlights,
              let tech = entity.technologiesAvailable
        else { return nil }
        
        self.fact = fact
        self.city = city
        self.state = state
        self.gpsLocation = CLLocationCoordinate2D(latitude: gpsLocation.latitude, longitude: gpsLocation.longitude)
        self.visitation = visitation
        self.cientificHighlight = FuncLib.shared.splitString(fromString: cientificHighlight, by: "\n")
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

extension SpaceMission {
    init?(from entity: SpaceMissionEntity) {
        guard let factEntity = entity.fact,
              let fact = Fact(from: factEntity),
              let launchLocation = entity.launchLocation,
              let missionType = entity.missionType,
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
        self.distanceTraveled = FuncLib.shared.measurementBuild(
				value: entity.distanceTraveled?.value,
				unitSymbol: entity.distanceTraveled?.unit,
				as: UnitLength.self)
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
              let typeDescriptive = entity.typeDescriptive,
              let visibilityEntity = entity.visibility,
              let visibility = VisibilityInfo(from: visibilityEntity)
        else { return nil }
        
        self.location = location
        self.diameter = FuncLib.shared.measurementBuild(
            value: entity.diameter?.value,
               unitSymbol: entity.diameter?.unit,
               as: UnitLength.self)
        self.typeDescriptive = typeDescriptive
        self.visibility = visibility
		self.rotationPeriod = TimePeriod(from: entity.rotationPeriod)
		self.translationPeriod = TimePeriod(from: entity.translationPeriod)
    }
}

extension PhysicalCharacteristics {
    init?(from entity: PhysicalCharacteristicsEntity) {
        self.mass = FuncLib.shared.measurementBuild(
            value: entity.mass?.value,
            unitSymbol: entity.mass?.unit,
            as: UnitMass.self)
		self.atmPressure = FuncLib.shared.measurementBuild(
			value: entity.atmPressure?.value,
			   unitSymbol: entity.atmPressure?.unit,
			   as: UnitPressure.self)
		self.gravity = FuncLib.shared.measurementBuild(
			value: entity.gravity?.value,
			   unitSymbol: entity.gravity?.unit,
			   as: UnitAcceleration.self)
		self.density = FuncLib.shared.measurementBuild(
			value: entity.density?.value,
			   unitSymbol: entity.density?.unit,
			   as: UnitConcentrationMass.self)
		self.temperature = entity.temperature
		self.atmosphere = entity.atmosphere
		self.surface = entity.surface
		self.moons = entity.moons
    }
}

extension KnowledgeBuild {
    init?(from entity: KnowledgeBuildEntity) {
		let culturalParallels = entity.culturalParallels ?? ""
		let trivia = entity.trivia ?? ""
		
		if culturalParallels.isEmpty && trivia.isEmpty { return nil }
		
        self.culturalParallels = FuncLib.shared.splitString(fromString: culturalParallels, by: "\n")
        self.trivia = FuncLib.shared.splitString(fromString: trivia, by: "\n")
    }
}

extension CelestialBody {
    init?(from entity: CelestialBodyEntity) {
        guard let factEntity = entity.fact,
              let fact = Fact(from: factEntity),
              let typeRawValue = entity.type,
              let type = CelestialBodyType(rawValue: typeRawValue),
              let mainInfoEntity = entity.mainInfo,
              let mainInfo = MainInfo(from: mainInfoEntity),
              let physicalCharEntity = entity.physicalCharacteristics,
              let physicalChar = PhysicalCharacteristics(from: physicalCharEntity),
              let triviaAndMithsEntity = entity.triviaAndMiths
        else { return nil }
		
		let historyAndObservation = entity.historyAndObservation ?? ""
		let exploringAndMission = entity.exploringAndMissions ?? ""
        
        self.fact = fact
		self.popularName = entity.popularName
        self.type = type
        self.mainInfo = mainInfo
        self.physicalCharacteristics = physicalChar
        self.historyAndObservation = FuncLib.shared.splitString(fromString: historyAndObservation, by: "\n")
        self.exploringAndMissions = FuncLib.shared.splitString(fromString: exploringAndMission, by: "\n")
        self.triviaAndMiths = KnowledgeBuild(from: triviaAndMithsEntity)
    }
}

extension ObservableEvent {
    init?(from entity: ObservableEventEntity) {
        guard let factEntity = entity.fact,
              let fact = Fact(from: factEntity),
              let dateEntity = entity.date,
              let date = DateTime(from: dateEntity),
              let visibilityEntity = entity.visibility,
              let visibility = VisibilityInfo(from: visibilityEntity),
              let typeRawValue = entity.type,
              let type = ObservableEventType(rawValue: typeRawValue)
        else { return nil }
        
        self.fact = fact
        self.date = date
        self.type = type
        self.explanation = entity.explanation
        self.visibility = visibility
    }
}
