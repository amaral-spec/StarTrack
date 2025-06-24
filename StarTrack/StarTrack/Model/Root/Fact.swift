//
//  Fact.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 17/06/25.
//

import SwiftUI

struct Fact: Identifiable, Decodable {
	let id = UUID()
	let name: String
	let image: AccessibleImage
	let mascotComment: String?
}
