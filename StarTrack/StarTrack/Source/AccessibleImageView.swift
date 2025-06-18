//
//  AccessibleImageView.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 17/06/25.
//

import SwiftUI

// Esta nova View aplica o modificador de acessibilidade de forma padronizada.
struct AccessibleImageView: View {
	let accessibleImage: AccessibleImage
	
	// O estado que irá guardar a imagem depois de carregada.
	@State private var image: Image? = nil
	 
	var body: some View {
		 Group {
			 if let image = image {
				 // Se a imagem já foi carregada, exibe-a.
				 image
					 .resizable()
					 .scaledToFill()
					 .accessibilityLabel(accessibleImage.alternativeText)
			 } else {
				 // Se a imagem ainda está a carregar, mostra um indicador de progresso.
				 ProgressView()
			 }
		 }
		 // Quando a view aparece, chama a função para carregar a imagem.
		 .onAppear(perform: loadImage)
		 // Se o ID da imagem mudar (indicando um objeto diferente), carrega a nova imagem.
		 .onChange(of: accessibleImage.id) { _ in
			 loadImage()
		 }
	 }
	 
	 private func loadImage() {
		 // 1. Verifica se existe um nome de imagem local.
		 if let localName = accessibleImage.localImage {
			 // 2. Tenta carregar a UIImage a partir do gestor local.
			 if let uiImage = LocalImageStorageManager.shared.load(filename: localName) {
				 // 3. Se teve sucesso, cria a View Image e atualiza o estado. A UI irá redesenhar.
				 self.image = Image(uiImage: uiImage)
			 } else {
				 // 4. Se não encontrou o ficheiro local, define uma imagem de placeholder.
				 self.image = Image(systemName: "photo.fill")
			 }
		 } else if let cloudAsset = accessibleImage.cloudImage {
			 Task {
				 guard let fileURL = cloudAsset.fileURL,
					   let data = try? Data(contentsOf: fileURL),
					   let uiImage = UIImage(data: data)
				 else {
					 self.image = Image(systemName: "photo.fill") // Placeholder
					 return
				 }
			 }
		 // Atualiza o estado com a imagem carregada.
		 self.image = Image(uiImage: uiImage)
		 }
	 }
}
