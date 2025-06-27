//
//  CatalogView.swift
//  StarTrack
//
//  Created by Aluno 10 on 16/06/25.
//

import SwiftUI

struct Card:View{
    var body: some View{
        
        ZStack(alignment: .bottomLeading){
            
            Rectangle()
                .frame(width: 160, height: 160)
                .background()
                .cornerRadius(10)
            
            VStack{
                Text("Titulo")
                    .foregroundColor(.white)
                    .padding(18)
            }
        }
    }
}


struct CatalogView: View {
     
    
    var body: some View{
        NavigationView{
        VStack(alignment: .leading ){
            VStack(spacing: 0){
            HStack{
                
               
               
            }
            
                
                TextField(" Pesquisar", text: .constant(""))
                    .frame(width: 343, height: 36, alignment: .leading)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding()
            }
            
            ScrollView(){
                VStack(alignment: .leading, spacing: 20){
                    Text("O que quer explorar?")
                    HStack(spacing: 23){
                        Card()
                        Card()
                    }
                    HStack(spacing: 23){
                        Card()
                        Card()
                    }
                    HStack(spacing: 23){
                        Card()
                        Card()
                    }
                }
                .padding(24)
                
                }
            
        }
        .navigationBarTitle("Catálogo")
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

//struct CatalogView: View {
//    var body: some View {
//
//
//        CardViewCatalog()
//    }
//}


struct CatalogView_Previews: PreviewProvider {
    static var previews: some View {
        
        //CardView()
        CatalogView()
        
    }
}
