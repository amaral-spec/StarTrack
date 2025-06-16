//
//  SelectDateView.swift
//  StarTrack
//
//  Created by Aluno 14 on 6/11/25.
//

import SwiftUI

struct SelectDateView: View {
    @State private var date = Date()
    @ObservedObject var manager: NetworkManager
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack{
            Text("Select a day").font(.headline).foregroundColor(.black)
            DatePicker(selection: $date, in: ...Date(), displayedComponents: .date){
                Text("Select").foregroundColor(.black)
            }.labelsHidden()
            
            Button(action: {
                self.manager.date = self.date
                self.presentation.wrappedValue.dismiss()
            }) {
                Text("Done").foregroundColor(.black)
            }
        }
    }
}

struct SelectDateView_Previews: PreviewProvider {
    static var previews: some View {
        SelectDateView(manager: NetworkManager())
    }
}
