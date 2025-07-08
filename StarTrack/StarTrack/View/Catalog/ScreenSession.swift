//
//  ScreenSession.swift
//  StarTrack
//
//  Created by Aluno 10 on 04/07/25.
//

import SwiftUI

struct ScreenSession: View {
    let catalogItem: Catalog  // recebe o item clicado
    
    @State private var searchText: String = ""

    var filteredContent: [Content] {
        if searchText.isEmpty {
            return catalogItem.content ?? []
        } else {
            return (catalogItem.content ?? []).filter {
                $0.title.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        SearchBar(text: $searchText)
                            .padding(.bottom)

                        ForEach(filteredContent) { item in
                            CardCalendar(name: item.title, imageName: item.name)
                        }
                    }
                    .padding()
                }
                .navigationTitle(catalogItem.title)
            }
}


struct ScreenSession_Previews: PreviewProvider {
    static var previews: some View {
        let fakeContent = [
            Content(id: 1, name: "earth", title: "Terra"),
            Content(id: 2, name: "mars", title: "Marte")
        ]
        let fakeCatalog = Catalog(id: 1, name: "planets", title: "Planetas", content: fakeContent)

        return NavigationView {
            ScreenSession(catalogItem: fakeCatalog)
        }
    }
}
