//
//  DateTime.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 17/06/25.
//

import Foundation

struct DateTime: Decodable {
	
	let startAt: Date
	let duration: TimeInterval
	let endAt: Date
	
//	/// A duração calculada entre 'startAt' e 'endAt'.
//	var duration: TimeInterval? {	// duration = segundos!
//		get {
//			guard endAt != Date.distantFuture else {
//				return nil
//			}
//			// Calcula e retorna a diferença em segundos.
//			return endAt.timeIntervalSince(startAt)
//		}
//	}
	
	init(startAt: Date, duration: TimeInterval) {
		self.startAt = startAt
		self.endAt = startAt.addingTimeInterval(duration)
		self.duration = duration
	}
}
