//
//  CodeSample.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 26/06/25.
//

import Foundation
import SwiftUI

@MainActor
class CelestialBodyViewModel: ObservableObject {
	
	@Published var celestialBodies: [CelestialBody] = []
	
	// Propriedade que a barra de pesquisa da UI irá usar.
	@Published var searchText: String = ""
	
	private let dataManager: CoreDataManager
	private var cancellables = Set<AnyCancellable>()
	
	init(context: NSManagedObjectContext) {
		self.dataManager = CoreDataManager(context: context)
		
		// --- Lógica de Busca Automática ---
		// Observa a propriedade 'searchText'.
		$searchText
			// Adiciona um atraso de 0.8 segundos para não fazer a busca a cada letra.
			.debounce(for: .seconds(0.8), scheduler: RunLoop.main)
			// Não faz uma nova busca se o texto for o mesmo (ex: apagar e reescrever rápido).
			.removeDuplicates()
			// Quando um novo valor passar por este pipeline, chama a função de busca.
			.sink { [weak self] newSearchText in
				self?.fetchData(searchText: newSearchText)
			}
			.store(in: &cancellables)
	}
	
	/// Pede ao gestor de dados para buscar os dados, aplicando o filtro de texto.
	func fetchData(searchText: String) {
		self.celestialBodies = dataManager.fetchCelestialBodies(searchText: searchText)
	}
	
	/// Função de busca para os botões de filtro de tipo.
	func fetchData(ofType type: CelestialBodyType?) {
		self.celestialBodies = dataManager.fetchCelestialBodies(ofType: type, searchText: self.searchText)
	}
}
