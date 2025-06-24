//
//  MainInfo.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 17/06/25.
//

import SwiftUI

struct MainInfo: Decodable {
	let location: String
	let diameter: Measurement<UnitLength>
	let distanceFromEarth: Measurement<UnitLength>
	let visibility: ViewingMethod
	let rotationPeriod: TimePeriod?
	let translationPeriod: TimePeriod?
}
