//
//  CelestialBody.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 17/06/25.
//

import SwiftUI

// MARK: - Enum para Tipo de Astro
enum CelestialBodyType: String {
	case planet = "body_type_planet"
	case naturalSatellite = "body_type_natural_satellite"
	case star = "body_type_star"
	case galaxy = "body_type_galaxy"
	case constellation = "body_type_constellation"
	case blackHole = "body_type_black_hole"
	case nebula = "body_type_nebula"
	case comet = "body_type_comet"
	case asteroidAndMeteor = "body_type_asteroid_and_meteor"
	case deepSpaceObjects = "body_type_deep_space_objects"
	
	// Propriedade computada para obter o nome localizado.
	var displayName: String {
		// Usa o rawValue da própria enum como a chave para o NSLocalizedString.
		return NSLocalizedString(self.rawValue, comment: "The name of a type of celestial body")
	}
}

struct CelestialBody: Identifiable {
	let fact: Fact
	var id: UUID { fact.id }
	let popularName: String?
	let type: CelestialBodyType
	let mainInfo: MainInfo
	let physicalCharacteristics: PhysicalCharacteristics
	let historyAndObservation: [String]
	let exploringAndMissions: [String]
	let triviaAndMiths: KnowledgeBuild
}

