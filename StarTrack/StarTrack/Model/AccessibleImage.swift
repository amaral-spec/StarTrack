//
//  AccessibleImage.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 17/06/25.
//

import SwiftUI

struct AccessibleImage: Identifiable {
	let id = UUID()
	let image: Image
	let alternativeText: String
}
