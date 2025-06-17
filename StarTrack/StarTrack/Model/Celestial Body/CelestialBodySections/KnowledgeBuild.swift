//
//  KnowledgeBuild.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 17/06/25.
// ATENCAO: ARQUIVO INCOMPLETO!

import Foundation

struct KnowledgeBuild {
	let culturalParallels: [CulturalParallel]?
	let spaceMisions: [SpaceMission]?
	
	init(culturalParallels: [CulturalParallel]? = nil,
		 spaceMisions: [SpaceMission]? = nil) {
		self.culturalParallels = culturalParallels
		self.spaceMisions = spaceMisions
	}
}
