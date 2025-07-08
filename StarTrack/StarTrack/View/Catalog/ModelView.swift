//
//  ModelView.swift
//  StarTrack
//
//  Created by Aluno 10 on 04/07/25.
//

import SwiftUI

struct ImageJson: Identifiable, Decodable, Hashable {
   
    let id: Int
    let name: String
    let title: String
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}


class ImageVModel: ObservableObject {
    @Published var images: [ImageJson] = []
    
    func loadImages() {
            if let url = Bundle.main.url(forResource: "imagescatalog", withExtension: "json"),
               let data = try? Data(contentsOf: url),
               let decoded = try? JSONDecoder().decode([ImageJson].self, from: data) {
                self.images = decoded
            }
        }
    
    
    init() {
        loadImages()
        print("Imagens sendo carregadas")
    }
    
    
}

