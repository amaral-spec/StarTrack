//
//  HistoricalCosmicEvent.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 18/06/25.
//

import SwiftUI

// MARK: - Enum para Tipos de Eventos Cosmológicos
enum CosmologicalEventType: String {
	case bigBang = "cosmological_event_big_bang"
	case inflation = "cosmological_event_inflation"
	case recombination = "cosmological_event_recombination"
	case darkAges = "cosmological_event_dark_ages"
	case reionization = "cosmological_event_reionization"
	case solarSystemFormation = "cosmological_event_solar_system_formation"
	case acceleratedExpansion = "cosmological_event_accelerated_expansion"
	
	// Propriedade computada para obter o nome localizado.
	var displayName: String {
		return NSLocalizedString(self.rawValue, comment: "The name of a major event in the history of the universe")
	}
}

struct HistoricalCosmicEvent: Identifiable {
	var id: UUID { fact.id }
	let fact: Fact
	let culturalParallels: [CulturalParallel]?
	let explanation: String
	let evidence: String
	let timePeriod: TimePeriod
	let type: CosmologicalEventType
	let scale: String

	init(
		fact: Fact,
		type: CosmologicalEventType,
		timePeriod: TimePeriod,
		scale: String,
		explanation: String,
		evidence: String,
		culturalParallels: [CulturalParallel]? = nil
	) {
		self.fact = fact
		self.culturalParallels = culturalParallels
		self.explanation = explanation
		self.evidence = evidence
		self.timePeriod = timePeriod
		self.type = type
		self.scale = scale
	}
}
