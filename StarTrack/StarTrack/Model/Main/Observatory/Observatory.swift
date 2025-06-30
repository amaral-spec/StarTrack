//
//  Observatory.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 18/06/25.
//

import SwiftUI
import CoreLocation

struct Observatory: Identifiable {
	var id: UUID { fact.id }
	let fact: Fact
	let city: String
	let state: String
	let gpsLocation: CLLocationCoordinate2D
	let visitation: Visitation
	let cientificHighlight: [String]
	let technologiesAvailable: [String]
}
