//
//  Observatory.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 18/06/25.
//

import SwiftUI

struct Observatory: Identifiable, Decodable {
	var id: UUID { fact.id }
	let fact: Fact
	let location: String //deveria ser localização?
	let visitation: Visitation
	let cientificHighlight: [String]?
	let technologiesAvailable: [String]?
}
