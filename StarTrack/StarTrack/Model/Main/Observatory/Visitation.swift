//
//  Visitation.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 18/06/25.
//

import Foundation

struct Visitation: Decodable {
	let openToPublic: String
	let tickets: [String]
	let activities: String?
}
