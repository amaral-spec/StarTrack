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
    var body: some View {
        VStack{
            VStack(spacing: 0){
            HStack(){
                Text("Calendário")
                    .frame(alignment: .topLeading)
                    .font(.title
                            .bold())
                    .padding(.horizontal, 24)
                
                Spacer()
                
                PerfilView()
                    
                }
            }
            ScrollView{
                VStack{
                    ForEach(0..<6){ _ in
                        CardCalendar()
                    }
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
