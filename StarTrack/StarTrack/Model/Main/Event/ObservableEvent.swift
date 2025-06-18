//
//  ObservableEvent.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 16/06/25.
//

import SwiftUI

// MARK: - Enum para Tipos de Eventos Cósmicos Observáveis
enum ObservableEventType: String {
	case meteorShower = "observable_event_meteor_shower"
	case eclipse = "observable_event_eclipse"
	case conjunction = "observable_event_conjunction"
	case opposition = "observable_event_opposition"
	case transit = "observable_event_transit"
	case occultation = "observable_event_occultation"
	case supernova = "observable_event_supernova"
	case cometPassage = "observable_event_comet_passage"
	case aurora = "observable_event_aurora"
	
	// Propriedade computada para obter o nome localizado.
	var displayName: String {
		return NSLocalizedString(self.rawValue, comment: "The name of a type of observable cosmic event")
	}
}

struct ObservableEvent: Identifiable {
	var id: UUID { fact.id }
	let fact: Fact
	let date: DateTime
	let type: ObservableEventType
	let explanation: String
	
	init(fact: Fact, date: DateTime, type: ObservableEventType, explanation: String) {
		self.fact = fact
		self.date = date
		self.type = type
		self.explanation = explanation
	}
}
