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
	
	init(mass: Measurement<UnitMass>,
		 temperature: Measurement<UnitTemperature>,
		 gravity: Measurement<UnitAcceleration>,
		 density: Measurement<UnitConcentrationMass>,
		 chemicalComposition: [ChemicalComponent]?) {
		self.mass = mass
		self.temperature = temperature
		self.gravity = gravity
		self.density = density
		self.chemicalComposition = chemicalComposition
	}
}
