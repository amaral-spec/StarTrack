//
//  PhysicalCharacteristics.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 17/06/25.
//

import Foundation

struct PhysicalCharacteristics {
	let mass: Measurement<UnitMass>
	let temperature: Measurement<UnitTemperature>
	let gravity: Measurement<UnitAcceleration>
	let density: Measurement<UnitConcentrationMass> // talvez não seja o mais adequado para astros
	let chemicalComposition: [ChemicalComponent]?
}
