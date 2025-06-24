//
//  Visitation.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 18/06/25.
//

import Foundation

struct Visitation: Decodable {
	let openToPublic: Bool
	let bookingNeeded: Bool
	let tickets: [String]?
}
