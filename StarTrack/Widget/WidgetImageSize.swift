//
//  WIdgetImageSize.swift
//  WidgetExtension
//
//  Created by Aluno 14 on 6/27/25.
//

import SwiftUI

struct WidgetImageSize: View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var widgetFamily
    
    private func getImageForWidgetSize() -> String {
        switch widgetFamily {
        case .systemSmall:
            return["imagens_app/widget_img/Cão maior - pequeno", "imagens_app/widget_img/Cruzeiro do Sul - pequeno", "imagens_app/widget_img/Orion - pequeno", "imagens_app/widget_img/Scorpius - pequeno", "imagens_app/widget_img/Triangulo Austral - pequeno"].randomElement() ?? "imagens_app/widget_img/Triangulo Austral - pequeno"
        case .systemMedium:
            return["imagens_app/widget_img/caomaior_medio", "imagens_app/widget_img/Cruzeiro do Sul - médio", "imagens_app/widget_img/Órion - médio", "imagens_app/widget_img/Scorpius - médio", "imagens_app/widget_img/Triângulo Austral - médio"].randomElement() ?? "imagens_app/widget_img/Triângulo Austral - médio"
        default:
            return "default_image"
        }
    }
    
    var body: some View {
        Image(getImageForWidgetSize())
    }
}
