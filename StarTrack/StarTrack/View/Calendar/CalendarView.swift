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
    let name: String
    let imageName: String
    
    init(name: String, imageName: String){
        self.name = name
        self.imageName = imageName
    }

    var body : some View{
        ZStack(alignment:.leading) {
            Image("\(imageName)")
                .resizable()
                .scaledToFill()
                .frame(width: 350, height: 106)
                .cornerRadius(10)
                .clipped()


            VStack(alignment: .leading){
                Text("\(name)")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(.leading, 12)
            }
//             Text("Data")
//                .font(.subheadline)
//                .foregroundColor(.white)
//
//             Text("Hora")
//                .font(.subheadline)
//                .foregroundColor(.white)
            }
            .padding(.horizontal,14)
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

    .frame(width: 350, height: 32, alignment: .center)
    .padding(.vertical,24)


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
    let events: [CalendarModel] = [
        CalendarModel(name: "Alfa-Capricórnidas", imageName: "Alfa-Capricórnidas"),
        CalendarModel(name: "Asteroide 63", imageName: "Asteroide 63"),
        CalendarModel(name: "Lua e M45", imageName: "Lua e M45"),
        CalendarModel(name: "Lua, Saturno e Netuno", imageName: "Lua, Saturno e Netuno"),
        CalendarModel(name: "Piscis Austrinid", imageName: "Piscis Austrinid")
    ]
    var body: some View{
        ScrollView {
            VStack {
                ForEach(events) { event in
                    CardCalendar(name: event.name, imageName: event.imageName)
                }
                .padding(.vertical, 2)
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
                            .padding(.top, 90)
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
