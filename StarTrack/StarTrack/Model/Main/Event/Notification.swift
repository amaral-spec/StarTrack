//
//  Notification.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 18/06/25.
//

import SwiftUI

struct Notification {
	let event: Event
	let description: String
	
	init(event: Event, description: String) {
		self.event = event
		self.description = description
	}
}
