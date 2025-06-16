//
//  SupabaseManager.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 16/06/25.
//

import Foundation

// MARK: - Supabase Manager (escrito com URLSession)
class SupabaseManager {
	
	static let shared = SupabaseManager()

	// --- Configuração ---
	private let supabaseURL = URL(string: "SUA_URL_AQUI")!
	private let supabaseKey = "SUA_CHAVE_ANON_AQUI"
	
	private let session: URLSession
	
	// Decodificador e codificador de JSON configurados para lidar com datas no formato ISO8601.
	private static var decoder: JSONDecoder {
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .iso8601
		return decoder
	}
	
	private static var encoder: JSONEncoder {
		let encoder = JSONEncoder()
		encoder.dateEncodingStrategy = .iso8601
		return encoder
	}

	private init() {
		let config = URLSessionConfiguration.default
		config.httpAdditionalHeaders = [
			"apikey": self.supabaseKey,
			"Authorization": "Bearer \(self.supabaseKey)",
			"Content-Type": "application/json"
		]
		self.session = URLSession(configuration: config)
	}
	
	// --- Funções CRUD para Eventos com Async/Await ---

	/// Busca todos os eventos da tabela.
	func fetchEvents() async throws -> [Event] {
		let requestURL = supabaseURL.appendingPathComponent("/rest/v1/events")
		let (data, _) = try await session.data(from: requestURL)
		let events = try Self.decoder.decode([Event].self, from: data)
		return events
	}
	
	/// Estrutura para criar um novo evento.
	struct NewEvent: Codable {
		let name: String
		let description: String
		let startAt: Date
		let observeInstructions: String

		enum CodingKeys: String, CodingKey {
			case name, description
			case startAt = "start_at"
			case observeInstructions = "observe_instructions"
		}
	}
	
	/// Adiciona um novo evento.
	func addEvent(newEvent: NewEvent) async throws -> Event {
		let requestURL = supabaseURL.appendingPathComponent("/rest/v1/events")
		var request = URLRequest(url: requestURL)
		request.httpMethod = "POST"
		request.httpBody = try Self.encoder.encode(newEvent)
		request.addValue("return=representation", forHTTPHeaderField: "Prefer")
		
		let (data, _) = try await session.data(for: request)
		let createdEvents = try Self.decoder.decode([Event].self, from: data)
		
		guard let newEvent = createdEvents.first else {
			throw URLError(.cannotParseResponse)
		}
		return newEvent
	}
	
	/// Deleta um evento pelo seu ID.
	func deleteEvent(id: UUID) async throws {
		var urlComponents = URLComponents(url: supabaseURL.appendingPathComponent("/rest/v1/events"), resolvingAgainstBaseURL: false)!
		urlComponents.queryItems = [URLQueryItem(name: "id", value: "eq.\(id.uuidString)")]
		
		guard let requestURL = urlComponents.url else {
			throw URLError(.badURL)
		}
		
		var request = URLRequest(url: requestURL)
		request.httpMethod = "DELETE"
		
		let (_, response) = try await session.data(for: request)
		
		guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
			throw URLError(.badServerResponse)
		}
	}
}
