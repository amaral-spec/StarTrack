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

        TabBar()

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
