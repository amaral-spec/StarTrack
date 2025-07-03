//
//  FuncLib.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 26/06/25.
//

import Foundation

class FuncLib {
	static let shared = FuncLib()
	
	private init() {}
	
	func splitString(fromString string: String?, by separator: String) -> [String] {
		guard let str = string else { return [] }
		
		return str.components(separatedBy: separator)
	}
	
	func measurementBuild<UnitType: Dimension>(
		value: Double?,
		unitSymbol: String?,
		as type: UnitType.Type
	) -> Measurement<UnitType>? {
		guard let value = value,
			  let unitSymbol = unitSymbol
		else { return nil }
		
		let unit = UnitType(symbol: unitSymbol)
		
		return Measurement(value: value, unit: unit)
	}
}
