//
//  TimePeriod.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 17/06/25.
//

import Foundation

// Enum para definir as unidades de tempo de forma segura.
enum TimeUnit: Equatable {
	case hours
	case days
	case earthYears
	case millionYears
	case other(String) // Permite outros períodos específicos.
	
	var displayName: String {
		switch self {
		case .hours:
			return NSLocalizedString("hours", comment: "Display name for hours")
		case .days:
			return NSLocalizedString("days", comment: "Display name for day")
		case .earthYears:
			return NSLocalizedString("earth-years", comment: "Display name for earth years")
		case .millionYears:
			return NSLocalizedString("million-years", comment: "Display name for million years")
		case .other(let customType):
			// Strings customizadas não são localizadas por padrão, pois são dinâmicas.
			return customType
		}
	}
}

// Estrutura para armazenar um valor e sua unidade de tempo correspondente.
struct TimePeriod {
	let value: Double
	let unit: TimeUnit
	
	// Uma propriedade computada para exibir o período de forma formatada.
	var formatted: String {
		// Formata o número para ter no máximo 2 casas decimais.
		let formattedValue = String(format: "%.2f", value)
		// Retorna a string completa, ex: "365.25 dias"
		return "\(formattedValue) \(unit.displayName)"
	}
}
