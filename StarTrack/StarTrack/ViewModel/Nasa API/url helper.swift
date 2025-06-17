//
//  url helper.swift
//  StarTrack
//
//  Created by Aluno 14 on 6/11/25.
//

import Foundation

extension URL {
    func withQuery(_ query: [String: String]) -> URL? {
        //adiciona a requisição do URL no formato certo
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = query.map { URLQueryItem(name: $0.0, value: $0.1)}
        return components?.url
    }
}
