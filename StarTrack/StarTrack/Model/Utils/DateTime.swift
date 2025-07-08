//
//  DateTime.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 17/06/25.
//

import Foundation

struct DateTime {
	
	let startAt: Date
	let duration: TimeInterval
	let endAt: Date
	
	init(startAt: Date, duration: TimeInterval) {
		self.startAt = startAt
		self.endAt = startAt.addingTimeInterval(duration)
		self.duration = duration
	}
}
