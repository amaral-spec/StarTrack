//
//  AccessibleImageView.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 17/06/25.
//

import SwiftUI

// Esta nova View aplica o modificador de acessibilidade de forma padronizada.
struct AccessibleImageView: View {
	let model: AccessibleImage

	var body: some View {
		model.image
			.accessibilityLabel(model.alternativeText)
	}
}
