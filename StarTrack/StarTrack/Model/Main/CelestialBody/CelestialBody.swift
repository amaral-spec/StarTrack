//
//  CelestialBody.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 17/06/25.
//

import SwiftUI

// MARK: - Enum para Tipo de Astro
enum CelestialBodyType: Equatable {
	case planet
	case naturalSatellite
	case star
	case galaxy
	case constellation
	case blackHole
	case nebula
	case comet
	case asteroidAndMeteor
	case deepSpaceObjects
	case other(String) // Permite outros corpos específicos.

	var displayName: String {
		switch self {
		case .planet:
			return NSLocalizedString("celestial_body_type_planet", comment: "Display name for Planet")
		case .naturalSatellite:
			return NSLocalizedString("celestial_body_type_natural_satellite", comment: "Display name for Natural Satellite")
		case .star:
			return NSLocalizedString("celestial_body_type_star", comment: "Display name for Star")
		case .galaxy:
			return NSLocalizedString("celestial_body_type_galaxy", comment: "Display name for Galaxy")
		case .constellation:
			return NSLocalizedString("celestial_body_type_constellation", comment: "Display name for Constellation")
		case .blackHole:
			return NSLocalizedString("celestial_body_type_black_hole", comment: "Display name for Black Hole")
		case .nebula:
			return NSLocalizedString("celestial_body_type_nebula", comment: "Display name for Nebula")
		case .comet:
			return NSLocalizedString("celestial_body_type_comet", comment: "Display name for Comet")
		case .asteroidAndMeteor:
			return NSLocalizedString("celestial_body_type_asteroid_meteor", comment: "Display name for Asteroid and Meteor")
		case .deepSpaceObjects:
			return NSLocalizedString("celestial_body_type_deep_space_objects", comment: "Display name for Deep Space Objects")
		case .other(let customType):
			// Strings customizadas não são localizadas por padrão, pois são dinâmicas.
			return customType
		}
	}
}

struct CelestialBody {
	let fact: Fact
	var id: UUID { fact.id }
	let popularName: String?
	let type: CelestialBodyType
	
	init(fact: Fact,
		 type: CelestialBodyType,
		 popularName: String? = nil) {
		self.fact = fact
		self.type = type
		self.popularName = popularName
	}
	
}

