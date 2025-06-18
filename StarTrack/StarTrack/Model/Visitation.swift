//
//  Visitation.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 18/06/25.
//

import Foundation

struct Visitation {
	let openToPublic: Bool
	let bookingNeeded: Bool
	let tickets: [String]?
	
	init(openToPublic: Bool, bookingNeeded: Bool, tickets: [String]? = nil) {
		self.openToPublic = openToPublic
		self.bookingNeeded = bookingNeeded
		self.tickets = tickets
	}
}
