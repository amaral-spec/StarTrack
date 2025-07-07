//
//  TabBar.swift
//  StarTrack
//
//  Created by Aluno 10 on 16/06/25.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView{
            CatalogView()
                .tabItem{
                    Image(systemName: "book")
                    Text("Catálogo")
                }
                .tag(0)
            CalendarView()
                .tabItem{
                    Image(systemName: "calendar")
                    Text("Calendário")
                }
                .tag(1)
            ObservatoriesView()
                .tabItem{
                    Image(systemName: "moon.stars")
                    Text("Observatórios")
                }
                .tag(2)
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
