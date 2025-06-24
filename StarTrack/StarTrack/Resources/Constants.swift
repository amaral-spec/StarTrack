//
//  Constants.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 10/06/25.
//

import SwiftUI

// MARK: - Design System (Sistema de Design)
// Centralize todas as constantes de design aqui.
struct DesignSystem {
	
	// MARK: - Padding Values
	struct Padding {
		static let extraSmall: CGFloat = 4
		static let small: CGFloat = 8
		static let medium: CGFloat = 16
		static let large: CGFloat = 24
		static let extraLarge: CGFloat = 32
	}

	// MARK: - Corner Radius Values
	struct CornerRadius {
		static let standard: CGFloat = 10
		static let large: CGFloat = 20
		}
	
	// MARK: - Spacing Values
	struct Spacing {
		static let extraSmall: CGFloat = 4
		static let small: CGFloat = 8
		static let medium: CGFloat = 16
		static let large: CGFloat = 24
		static let extraLarge: CGFloat = 32
	}
}

// MARK: - Color Values
extension Color {
	static let accentHighlight = Color("Highlight")
	static let backgroundBase = Color("Base")
	static let backgroundCard = Color("Card")
	static let backgroundMuted = Color("BackgroundMuted")
	static let borderDefault = Color("BorderDefault")
	static let feedbackError = Color("Error")
	static let feedbackSuccess = Color("Success")
	static let feedbackWarning = Color("Warning")
	static let primaryDefault = Color("PrimaryDefault")
	static let primaryHover = Color("Hover")
	static let primaryMuted = Color("PrimaryMuted")
	static let secundaryBackground = Color("Background")
	static let secundaryDefault = Color("SecundaryDefault")
	static let textMuted = Color("TextMuted")
	static let textPrimary = Color("Primary")
	static let textSecundary = Color("Secundary")
}
