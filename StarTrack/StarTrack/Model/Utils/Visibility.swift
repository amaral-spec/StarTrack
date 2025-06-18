//
//  Visibility.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 17/06/25.
//

import Foundation

// MARK: - Enum para o Método de Visualização
enum ViewingMethod: Equatable {
	case nakedEye
	case binoculars
	case telescope
	case other(String) // Permite outros instrumentos específicos.

	var displayName: String {
		switch self {
		case .nakedEye:
			return NSLocalizedString("viewing_method_naked_eye", comment: "Display name for naked eye viewing method")
		case .binoculars:
			return NSLocalizedString("viewing_method_binoculars", comment: "Display name for binoculars viewing method")
		case .telescope:
			return NSLocalizedString("viewing_method_telescope", comment: "Display name for telescope viewing method")
		case .other(let instrument):
			return instrument // Strings customizadas não são localizadas por padrão.
		}
	}
}


// MARK: - Estrutura Principal de Visibilidade
struct VisibilityInfo {
	
	let viewingMethod: ViewingMethod
	
	// A região geral onde a observação é possível (ex: "Hemisfério Sul").
	let observationZone: String
	
	// Uma sub-região mais específica para a melhor experiência (opcional).
	let bestSubzone: String?
	
	// Instruções detalhadas sobre como e quando observar.
	let instructions: String
}
