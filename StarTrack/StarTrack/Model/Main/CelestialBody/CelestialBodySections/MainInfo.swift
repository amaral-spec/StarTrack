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
	let typeDescriptive: String
	let visibility: VisibilityInfo
	let rotationPeriod: TimePeriod?
	let translationPeriod: TimePeriod?
}
