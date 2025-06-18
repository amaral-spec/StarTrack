//
//  ImageStorageManager.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 18/06/25.
//

import SwiftUI
import CoreData

// MARK: - Gestor de Armazenamento de Imagens com o FileManager
class LocalImageStorageManager {
	static let shared = LocalImageStorageManager()
	
	private let fileManager = FileManager.default
	private let documentsDirectory: URL
	
	private init() {
		// Obtém o URL para o diretório de documentos da aplicação.
		self.documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
	}
	
	/// Guarda uma UIImage no disco e retorna o nome único do ficheiro.
	func save(image: UIImage) -> String? {
		guard let data = image.jpegData(compressionQuality: 0.8) else {
			print("Erro ao converter a imagem para dados JPEG.")
			return nil
		}
		
		// Gera um nome de ficheiro único.
		let filename = UUID().uuidString + ".jpg"
		let fileURL = documentsDirectory.appendingPathComponent(filename)
		
		do {
			try data.write(to: fileURL)
			return filename // Retorna o nome do ficheiro em caso de sucesso.
		} catch {
			print("Erro ao guardar a imagem no disco: \(error)")
			return nil
		}
	}
	
	/// Carrega uma UIImage do disco a partir do seu nome de ficheiro.
	func load(filename: String) -> UIImage? {
		let fileURL = documentsDirectory.appendingPathComponent(filename)
		do {
			let data = try Data(contentsOf: fileURL)
			return UIImage(data: data)
		} catch {
			// É normal não encontrar um ficheiro, por isso não imprimimos sempre o erro.
			// print("Erro ao carregar a imagem do disco: \(error)")
			return nil
		}
	}
	
	/// Apaga uma imagem do disco.
	func delete(filename: String) {
		let fileURL = documentsDirectory.appendingPathComponent(filename)
		do {
			try fileManager.removeItem(at: fileURL)
		} catch {
			print("Erro ao apagar a imagem do disco: \(error)")
		}
	}
}


// MARK: - Gestor de Dados do Core Data
// Funções que orquestram o Core Data e o FileManager.
extension PersistenceController {
	
	/// Cria e guarda uma nova imagem, tanto no disco como no Core Data.
	func addImage(uiImage: UIImage, alternativeText: String) {
		// 1. Tenta guardar a imagem no disco primeiro.
		guard let filename = LocalImageStorageManager.shared.save(image: uiImage) else {
			return // Se falhar, não faz mais nada.
		}
		
		// 2. Se a imagem foi guardada com sucesso, cria a entidade no Core Data.
		let newImageEntity = AccessibleImageEntity(context: container.viewContext)
		newImageEntity.id = UUID()
		newImageEntity.alternativeText = alternativeText
		newImageEntity.imageFilename = filename // Guarda apenas o nome do ficheiro.
		
		// 3. Salva o contexto do Core Data.
		saveContext()
	}
	
	/// Apaga uma entidade e o seu ficheiro de imagem correspondente.
	func deleteImage(entity: AccessibleImageEntity) {
		// 1. Obtém o nome do ficheiro antes de apagar a entidade.
		if let filename = entity.imageFilename {
			LocalImageStorageManager.shared.delete(filename: filename)
		}
		
		// 2. Apaga a entidade do Core Data.
		container.viewContext.delete(entity)
		
		// 3. Salva o contexto.
		saveContext()
	}
	
	// Função auxiliar para salvar o contexto
	func saveContext() {
		do {
			try container.viewContext.save()
		} catch {
			print("Erro ao salvar o contexto do Core Data: \(error)")
		}
	}
}
