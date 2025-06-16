//
//  Event.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 16/06/25.
//

import Foundation

struct Event: Codable, Identifiable, Equatable {
	let id: UUID
	let name: String?
	let description: String?
	let startAt: Date
	let endAt: Date?
	let visibility: Int?
	let observableZone: String?
	let bestZone: String?
	let observeInstructions: String

	// Mapeia os nomes das colunas (snake_case) para as propriedades (camelCase).
	enum CodingKeys: String, CodingKey {
		case id, name, description, visibility
		case startAt = "start_at"
		case endAt = "end_at"
		case observableZone = "observable_zone"
		case bestZone = "best_zone"
		case observeInstructions = "observe_instructions"
	}
}
