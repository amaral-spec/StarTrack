//
//  ChemicalComponent.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 17/06/25.
//

import Foundation

enum ChemicalElement: String, Decodable {
	case hydrogen = "element_hydrogen"
	case helium = "element_helium"
	case oxygen = "element_oxygen"
	case silicon = "element_silicon"
	case iron = "element_iron"
	case heavyElements = "element_heavy_elements" // Para um grupo genérico

	var displayName: String {
		return NSLocalizedString(self.rawValue, comment: "The name of a chemical element")
	}
}

struct ChemicalComponent: Decodable {
	let element: ChemicalElement
	let percentage: Double
}
