//
//  SwiftUIView.swift
//  StarTrack
//
//  Created by Aluno 10 on 25/06/25.
//

import SwiftUI

struct FavoritesView: View {
    var body: some View {
        VStack{
            Text("Tela mudou")
            ScrollCardView()
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
