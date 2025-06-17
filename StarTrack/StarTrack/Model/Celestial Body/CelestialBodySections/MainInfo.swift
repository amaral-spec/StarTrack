//
//  MainInfo.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 17/06/25.
//

import SwiftUI

struct MainInfo {
	let location: String
	let diameter: Measurement<UnitLength>
	let distanceFromEarth: Measurement<UnitLength>
	let visibility: ViewingMethod
	let rotationPeriod: TimePeriod?
	let translationPeriod: TimePeriod?
	
	init(location: String,
		 diameter: Measurement<UnitLength>,
		 distanceFromEarth: Measurement<UnitLength>,
		 visibility: ViewingMethod,
		 rotationPeriod: TimePeriod? = nil,
		 translationPeriod: TimePeriod? = nil) {
		self.location = location
		self.diameter = diameter
		self.distanceFromEarth = distanceFromEarth
		self.visibility = visibility
		self.rotationPeriod = rotationPeriod
		self.translationPeriod = translationPeriod
	}
}
