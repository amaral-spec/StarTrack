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

struct choicesUserView: View {
    @State private var selected = "Calendar"
    let options = ["Calendar", "Favorites"]
    
    var body: some View{
        
        
    Picker("", selection: $selected){
        ForEach(options, id: \.self) { option in
            Text(option)
        }
    }
    .pickerStyle(.segmented)
    .frame(width: 344, height: 32, alignment: .center)

if selected == "Calendar" {
                    // Conteúdo do Calendário
                    ScrollCardView()
                } else {
                    // Tela de Favoritos
                    FavoritesView()
                }
    }
}

struct ScrollCardView: View {
    var body: some View{
        ScrollView {
            VStack {
                ForEach(0..<6) { _ in
                    CardCalendar()
                }
            }
        }
    }
}

struct CalendarView: View {
   
    
    var body: some View {
        NavigationView{
            
            VStack{
                    choicesUserView()


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
