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
		
		return str.components(separatedBy: separator).map { $0.trimmingCharacters(in: .whitespaces) }
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
	
	func createEnum<T: RawRepresentable>(from rawValue: String?) -> T? where T.RawValue == String {
		guard let rawValue = rawValue else { return nil }
		return T(rawValue: rawValue)
	}
}
