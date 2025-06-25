//
//  PerfilView.swift
//  StarTrack
//
//  Created by Aluno 14 on 6/25/25.
//

import SwiftUI

struct PerfilView: View {
    var body: some View {
        Image(systemName: "person.crop.circle")
            .resizable()
            .frame(width: 50, height: 50, alignment: .topTrailing)
            .foregroundColor(.gray)
            .padding(.horizontal, 24)
    }
}

struct PerfilView_Previews: PreviewProvider {
    static var previews: some View {
        PerfilView()
    }
}
