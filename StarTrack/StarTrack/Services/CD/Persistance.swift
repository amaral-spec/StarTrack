//
//  Persistance.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 18/06/25.
//

import CoreData

struct PersistenceController {
	static let shared = PersistenceController()

	let container: NSPersistentContainer

	private init(inMemory: Bool = false) {
		
		// Cria o container, passando o nome do seu ficheiro de modelo de dados (.xcdatamodeld).
		// Certifique-se de que "StarTrack" corresponde exatamente ao nome do seu ficheiro.
		container = NSPersistentContainer(name: "StarTrack")
		
		// Esta parte é usada principalmente para testes ou previews do SwiftUI,
		// onde os dados são guardados na memória em vez de no disco.
		if inMemory {
			container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
		}
		
		// Carrega o banco de dados do disco e o deixa pronto para uso.
		// Se houver um erro aqui, é um problema sério (ex: o modelo mudou, o disco está corrompido),
		// e a aplicação irá parar com um erro fatal para que possa ser depurado.
		container.loadPersistentStores(completionHandler: { (storeDescription, error) in
			if let error = error as NSError? {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		})
		
		// Gerencia o seeding do app ao abrir o app
		let seeder = CoreDataSeeder(context: container.viewContext)
		seeder.seedDatabaseIfNeeded()
	}
}
