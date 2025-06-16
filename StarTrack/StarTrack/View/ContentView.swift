//
//  ContentView.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 09/06/25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var manager = NetworkManager()
    @State private var showSwitchDate: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 20){
            Button(action: {
                self.showSwitchDate.toggle()
            }) {
                Image(systemName: "calendar").foregroundColor(.black)
                Text("Switch day").foregroundColor(.black)
            }
            .padding(.trailing)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .popover(isPresented: $showSwitchDate) {
                SelectDateView(manager: self.manager)
            }
            
            if manager.image != nil {
                Image(uiImage: self.manager.image!)
                    .resizable()
                    .scaledToFit()
            }
            
            ScrollView{
                VStack(alignment: .leading, spacing: 10){
                    Text(manager.photoInfo.title).font(.title)
                    Text(manager.photoInfo.date).font(.headline)
                    Text(manager.photoInfo.description )
                }
            }.padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let view = ContentView()
        view.manager.photoInfo = PhotoInfo.createDefault()
        view.manager.image = UIImage(named: "preview_image")
        return view
    }
}
