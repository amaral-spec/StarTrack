//
//  TimePeriod.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 17/06/25.
//

import Foundation

// MARK: - Enum para Unidades de Tempo
enum TimeUnit: String {
	case hours = "time_unit_hours"
	case days = "time_unit_days"
	case earthYears = "time_unit_earth_years"
	case millionYears = "time_unit_million_years"

	// Propriedade computada para obter o nome localizado.
	var displayName: String {
		// Usa o rawValue da própria enum como a chave para o NSLocalizedString.
		return NSLocalizedString(self.rawValue, comment: "The name of a unit of time")
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
