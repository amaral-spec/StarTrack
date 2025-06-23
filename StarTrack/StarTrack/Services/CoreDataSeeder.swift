//
//  CoreDataSeeder.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 23/06/25.
//

import Foundation
import CoreData

// MARK: - O Seeder do Core Data
// Esta classe irá orquestrar a leitura dos JSONs e a população do Core Data.
class CoreDataSeeder {
	
	// O contexto do Core Data onde os novos objetos serão criados.
	private let context: NSManagedObjectContext
	
	// As estruturas intermédias para descodificar os JSONs permanecem as mesmas.
	private struct ImageData: Codable { let id: UUID; let imageName: String; let alternativeText: String }
	private struct FactData: Codable { let id: UUID; let name: String; let mascotComment: String?; let image_id: UUID }
	private struct CelestialBodyData: Codable { let id: UUID; let type: CelestialBodyType; let fact_id: UUID }
	
	/// O inicializador recebe o contexto do Core Data a partir do seu PersistenceController.
	init(context: NSManagedObjectContext) {
		self.context = context
	}
	
	/// Função principal que verifica se a base de dados já foi populada e, se não, fá-lo.
	func seedDatabaseIfNeeded() {
		// Usamos UserDefaults para guardar uma "bandeira" que nos diz se já fizemos este processo.
		let defaults = UserDefaults.standard
		guard !defaults.bool(forKey: "isDatabaseSeeded") else {
			print("INFO: A base de dados Core Data já foi populada anteriormente.")
			return
		}
		
		print("INFO: Populando a base de dados Core Data pela primeira vez...")
		
		// 1. Descodifica cada ficheiro JSON para os seus arrays de dados planos.
		let imagesData: [ImageData] = load("accessible_images.json")
		let factsData: [FactData] = load("facts.json")
		let bodiesData: [CelestialBodyData] = load("celestial_bodies.json")
		
		// 2. Cria as Entidades Core Data e guarda-as em dicionários para uma busca rápida.
		let imageEntities = Dictionary(uniqueKeysWithValues: imagesData.map { data -> (UUID, AccessibleImageEntity) in
			let entity = AccessibleImageEntity(context: context)
			entity.id = data.id
			entity.imageName = data.imageName
			entity.alternativeText = data.alternativeText
			return (data.id, entity)
		})
		
		let factEntities = Dictionary(uniqueKeysWithValues: factsData.map { data -> (UUID, FactEntity) in
			let entity = FactEntity(context: context)
			entity.id = data.id
			entity.name = data.name
			entity.mascotComment = data.mascotComment
			// 3. Define a relação: encontra a entidade da imagem correspondente e liga-a.
			if let imageEntity = imageEntities[data.image_id] {
				entity.image = imageEntity
			}
			return (data.id, entity)
		})
		
		bodiesData.forEach { data in
			let entity = CelestialBodyEntity(context: context)
			entity.id = data.id
			entity.type = data.type.rawValue
			// 4. Define a relação: encontra a entidade do facto correspondente e liga-a.
			if let factEntity = factEntities[data.fact_id] {
				entity.fact = factEntity
			}
		}
		
		// 5. Salva o contexto para gravar permanentemente todos os novos objetos na base de dados.
		do {
			try context.save()
			// Se o salvamento for bem-sucedido, marca a "bandeira" para não repetir este processo.
			defaults.set(true, forKey: "isDatabaseSeeded")
			print("SUCCESS: Base de dados Core Data populada e guardada com sucesso.")
		} catch {
			// Se houver um erro, imprime-o para depuração.
			print("ERROR: Falha ao guardar o contexto inicial do Core Data. \(error)")
		}
	}
	
	// --- Função auxiliar genérica para descodificar um ficheiro JSON ---
	private func load<T: Decodable>(_ filename: String) -> T {
		guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
			fatalError("Não foi possível encontrar o ficheiro \(filename) no bundle principal.")
		}
		guard let data = try? Data(contentsOf: file) else {
			fatalError("Não foi possível carregar o ficheiro \(filename) do bundle.")
		}
		do {
			return try JSONDecoder().decode(T.self, from: data)
		} catch {
			fatalError("Não foi possível descodificar o ficheiro \(filename) como \(T.self):\n\(error)")
		}
	}
}
