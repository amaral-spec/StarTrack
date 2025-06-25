//
//  CalendarView.swift
//  StarTrack
//
//  Created by Aluno 10 on 16/06/25.
//

import SwiftUI

struct CardCalendar:View {
//    var title = "Evento"
//    var date: Date
    
    
    var body : some View{
        ZStack(alignment:.leading){
            
            Image("earth")
            //.resizable()
                .frame(width: 344, height: 106)
                .cornerRadius(10)
                .clipped()
            
            
            VStack(alignment: .leading){
                
                Text("Titulo")
                    .font(.title2)
                    .foregroundColor(.white)
                
                
                Text("Data")
                    .font(.subheadline)
                    .foregroundColor(.white)
                
                Text("Hora")
                    .font(.subheadline)
                    .foregroundColor(.white)
                
            }
            .padding(14)
        }
    }
}

struct CalendarView: View {
    @State private var selected = "Calendar"
    let options = ["Calendar", "Favorites"]
    
    var body: some View {
        NavigationView{
            
            VStack{
                    
                    Picker("Escolha uma opção", selection: $selected){
                        ForEach(options, id: \.self) { option in
                            Text(option)
                        }
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 344, height: 32, alignment: .center)

                if selected == "Calendar" {
                                    // Conteúdo do Calendário
                                    ScrollView {
                                        VStack {
                                            ForEach(0..<6) { _ in
                                                CardCalendar()
                                            }
                                        }
                                    }
                                } else {
                                    // Tela de Favoritos
                                    FavoritesView()
                                }
                
//                    Group {
//                        if selected == "Calendar" {
//                            CalendarScreen()
//                        } else if selected == "Favorites"{
//                            FavoritesView()
//                        }
//                    }
//
//
//                ScrollView{
//                    VStack{
//                        ForEach(0..<6){ _ in
//                            CardCalendar()
//                        }
//                    }
//                }
            }
            .navigationTitle("Calendário")

        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
        
    }
}
