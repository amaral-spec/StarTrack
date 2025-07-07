//
//  CatalogView.swift
//  StarTrack
//
//  Created by Aluno 10 on 16/06/25.
//

import SwiftUI


struct Card:View{
    
    var imageName: String
    var title: String
    
    var body: some View{
        
        ZStack(alignment: .bottomLeading){
            
            Image(imageName)
                .resizable()
                .frame(width: 160, height: 160)
                .aspectRatio(1, contentMode: .fill)
                .clipped()
                .cornerRadius(10)
                
            
            VStack{
                Text(title)
                    .foregroundColor(.white)
                    .padding(18)
            }
        }
    }
}


struct CatalogView: View {
    @StateObject private var viewModel = ImageVModel()
    @State private var searchText: String = ""
    
    var filteredImages: [ImageJson] {
            if searchText.isEmpty {
                return viewModel.images
            } else {
                return viewModel.images.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
            }
        }
    
    var body: some View{
        
        NavigationView{
            VStack(alignment: .leading ){
                    SearchBar(text: $searchText)
                    .padding(.horizontal)
                    .padding(.top)
                ScrollView(){
                    VStack(alignment: .leading, spacing: 20){
                        Text("O que quer explorar?")
                            .font(.headline)
                        ForEach(filteredImages.chunked(into: 2), id: \.self) { linha in
                            HStack(spacing: 23) {
                                ForEach(linha) { immage  in
                                    NavigationLink(destination: ScreenSession()) {
                                        Card(imageName: immage.name, title: immage.title)
                                    }
                                }
                            }
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
