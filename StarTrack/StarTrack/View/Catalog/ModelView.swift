//
//  ModelView.swift
//  StarTrack
//
//  Created by Aluno 10 on 04/07/25.
//

import SwiftUI

struct Catalog: Decodable, Identifiable, Hashable {
    let id: Int
    let name: String
    let title: String
    let content: [Content]?
}

struct Content: Decodable, Identifiable, Hashable {
    let id: Int
    let name: String
    let title: String
}

struct ImageCatalog: Decodable {
        let catalog: [Catalog]

}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}


class ImageVModel: ObservableObject {
    @Published var catalog: [Catalog] = []

    

    
    
    func loadImages() {
        if let url = Bundle.main.url(forResource: "imagescatalog", withExtension: "json"),
                   let data = try? Data(contentsOf: url),
                   let decoded = try? JSONDecoder().decode(ImageCatalog.self, from: data) {

            self.catalog = decoded.catalog

        }
    }
    
    
    init() {
        loadImages()
        print("Imagens sendo carregadas")
    }
}

