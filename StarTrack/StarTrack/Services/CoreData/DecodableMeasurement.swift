//
//  DecodableMeasurement.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 24/06/25.
//

import Foundation

struct DecodableMeasurement<Unit: Dimension>: Decodable {
	let value: Double
	let unit: String // Descodificado a partir da chave "unit" do JSON

	// Uma propriedade computada que faz a conversão para o tipo real.
	var measurement: Measurement<Unit> {
		let unit = Unit(symbol: unit)
		return Measurement(value: value, unit: unit)
	}
}
