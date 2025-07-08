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
        
        
        ZStack(alignment: .bottomLeading) {
                    Image(imageName)
                        .resizable()
                        .aspectRatio(1, contentMode: .fill)
                        .frame(width: 160, height: 160)
                        .clipped()
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("ColorSchemeStroke"), lineWidth: 1)
                        )

                   
                    Text(title)
                        .font(.headline.bold()) // Negrito
                        .foregroundColor(.white)
                        .padding(5)
                        .cornerRadius(5)
                        .padding([.leading, .bottom], 7)
                }
                .frame(width: 160, height: 160)
            }
}


struct CatalogView: View {
    @StateObject private var viewModel = ImageVModel()
    @State private var searchText: String = ""
    
    var filteredImages: [Catalog] {
            if searchText.isEmpty {
                return viewModel.catalog
            } else {
                return viewModel.catalog.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
            }
        }
    
    var body: some View{
        
       
//            VStack {
//                Text("Total de cards: \(filteredImages.count)")
//                ForEach(filteredImages) { image in
//                    Text(image.title)
//                        .padding()
//                        .background(Color.yellow)
//                }
//            }
//        }    BLoco de teste, para ver se os cards aparecem

        
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
