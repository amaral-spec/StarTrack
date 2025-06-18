//
//  Observatory.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 18/06/25.
//

import SwiftUI

struct Observatory: Identifiable {
	var id: UUID { fact.id }
	let fact: Fact
	let location: String //deveria ser localização?
	let visitation: Visitation
	let cientificHighlight: [String]?
	let technologiesAvailable: [String]?
	
	init(fact: Fact,
		 location: String,
		 visitation: Visitation,
		 cientificHighlight: [String]? = nil,
		 technologiesAvailable: [String]? = nil) {
		self.fact = fact
		self.location = location
		self.visitation = visitation
		self.cientificHighlight = cientificHighlight
		self.technologiesAvailable = technologiesAvailable
	}
}
