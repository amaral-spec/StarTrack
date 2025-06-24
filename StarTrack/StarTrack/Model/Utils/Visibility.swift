//
//  Visibility.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 17/06/25.
//

import Foundation

// MARK: - Enum para o Método de Visualização (Padrão Novo)
enum ViewingMethod: String, Decodable {
	case nakedEye = "viewing_method_naked_eye"
	case binoculars = "viewing_method_binoculars"
	case telescope = "viewing_method_telescope"
	
	// Propriedade computada para obter o nome localizado.
	var displayName: String {
		// Usa o rawValue da própria enum como a chave para o NSLocalizedString.
		return NSLocalizedString(self.rawValue, comment: "The name of a viewing method for a celestial object")
	}
}


// MARK: - Estrutura Principal de Visibilidade
struct VisibilityInfo: Decodable {
	
	let viewingMethod: ViewingMethod
	
	// A região geral onde a obsviewervação é possível (ex: "Hemisfério Sul").
	let observationZone: String
	
	// Uma sub-região mais específica para a melhor experiência (opcional).
	let bestSubzone: String?
	
	// Instruções detalhadas sobre como e quando observar.
	let instructions: String
}
