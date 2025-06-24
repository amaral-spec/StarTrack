//
//  PhysicalCharacteristics.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 17/06/25.
//

import Foundation

struct PhysicalCharacteristics: Decodable {
	let mass: Measurement<UnitMass>?
	let temperature: String?
	let atmosphere: String?
	let atmPressure: String?
	let surface: String?
	let gravity: Measurement<UnitAcceleration>?
	let density: Measurement<UnitConcentrationMass>?
	let moons: String?
}
