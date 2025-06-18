//
//  AccessibleImage.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 17/06/25.
//

import SwiftUI
import CloudKit

struct AccessibleImage: Identifiable {
	let id: UUID
	let alternativeText: String
	
	// Propriedade para imagens locais (guardadas nos Assets).
	// Será preenchida se a imagem vier do Core Data.
	let localImage: String?
	
	// Propriedade para imagens remotas (guardadas no CloudKit).
	// Será preenchida se a imagem vier do CloudKit.
	let cloudImage: CKAsset?
	
	// Inicializador para uma IMAGEM LOCAL (Core Data).
	init(id: UUID, alternativeText: String, localImage: String) {
		self.id = id
		self.alternativeText = alternativeText
		self.localImage = localImage
		self.cloudImage = nil // Garante que a outra fonte é nula.
	}
	
	// Inicializador para uma IMAGEM REMOTA (CloudKit).
	init(id: UUID, alternativeText: String, cloudImage: CKAsset) {
		self.id = id
		self.alternativeText = alternativeText
		self.localImage = nil // Garante que a outra fonte é nula.
		self.cloudImage = cloudImage
	}
}
