//
//  DecodableMeasurement.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 24/06/25.
//

import Foundation

struct DecodableMeasurement<Unit: Dimension>: Codable {
	let value: Double
	private let unitSymbol: String

	// Propriedade computada que faz a conversão para o tipo real.
	var measurement: Measurement<Unit> {
		let unit = Unit(symbol: unitSymbol)
		return Measurement(value: value, unit: unit)
	}
	
	// Mapeia a chave "unit" do JSON para a nossa propriedade "unitSymbol".
	private enum CodingKeys: String, CodingKey {
		case value, unitSymbol = "unit"
	}

	// A lógica de descodificação (JSON -> Struct) é gerada automaticamente pelo Swift.
	// A lógica de codificação (Struct -> JSON) precisa de ser explícita.
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(self.value, forKey: .value)
		try container.encode(self.unitSymbol, forKey: .unitSymbol)
	}
}
