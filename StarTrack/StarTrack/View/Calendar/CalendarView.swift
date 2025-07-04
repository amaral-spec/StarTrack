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
            .padding(.horizontal,14)
            
        }
    }
}

struct choicesUserView: View {
    @State private var selected = "Eventos"
    let options = ["Eventos", "Favoritos"]
    
    var body: some View{
        
        
    Picker("", selection: $selected){
        ForEach(options, id: \.self) { option in
            Text(option)
        }
    }
    .pickerStyle(.segmented)
    .frame(width: 344, height: 32, alignment: .center)
    .padding(.vertical, 10)

if selected == "Eventos" {
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
                .padding(.vertical, 12)
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
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    NavigationLink(destination: PerfilView(), label: {
                        Image(systemName: "person.crop.circle")
                            .font(.system(size: 25))
                            .foregroundColor(.black)
                            .frame(width: 50)
                            .padding(.top)
                    })
                }
            }
            
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
        
    }
}
