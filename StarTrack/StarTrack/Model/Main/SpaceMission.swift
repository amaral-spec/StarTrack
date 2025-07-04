//
//  SpaceMission.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 17/06/25.
//

import SwiftUI

//// MARK: - Enum para Tipos de Missão Espacial
//enum SpaceMissionType: String, Decodable {
//	case flyby = "mission_type_flyby"
//	case orbiter = "mission_type_orbiter"
//	case lander = "mission_type_lander"
//	case rover = "mission_type_rover"
//	case impactor = "mission_type_impactor"
//	case sampleReturn = "mission_type_sample_return"
//	case spaceTelescope = "mission_type_space_telescope"
//	case humanMission = "mission_type_human_mission"
//
//	var displayName: String {
//		return NSLocalizedString(self.rawValue, comment: "The name of a type of space mission")
//	}
//}

struct SpaceMission: Identifiable {
	let fact: Fact
	var id: UUID { fact.id }
	let launchLocation: String
	let missionType: String
	let distanceTraveled: Measurement<UnitLength>?
	let date: DateTime
	let objectives: [String]
	let results: [String]
	let highlights: [String]
	let techEnvolved: [String]
}
