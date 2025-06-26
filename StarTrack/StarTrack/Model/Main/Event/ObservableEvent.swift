//
//  ObservableEvent.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 16/06/25.
//

import SwiftUI
import CloudKit

// MARK: - Enum para Tipos de Eventos Cósmicos Observáveis
enum ObservableEventType: String, Decodable {
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

struct ObservableEvent: Identifiable, Decodable {
	var id: UUID { fact.id }
	let fact: Fact
	let date: DateTime
	let type: ObservableEventType
	let explanation: String
	
//	// Integracao CloudKit
//	fileprivate let record: CKRecord
//	static let recordType = "ObservableEvent"
//
//	// Inicializador CKRecord -> ObservableEvent
//	init?(from record: CKRecord) {
//		// Valida que o campo "name" existe e é uma String.
//		guard let name = record["name"] as? String else {
//		   return nil
//		}
//
//		// O ID do nosso objeto é o nome do registo do CloudKit.
//		self.id = UUID(uuidString: record.recordID.recordName) ?? UUID()
//		self.name = name
//		self.record = record
//	}
}
