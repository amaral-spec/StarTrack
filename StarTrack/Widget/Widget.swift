//
//  Widget.swift
//  Widget
//
//  Created by Aluno 14 on 6/12/25.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    let placeHolderImage = Image("default_image")
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), title: "Placeholder", image: placeHolderImage)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), title: "Placeholder", image: placeHolderImage)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        //define os dados que serão mostrados
        fetchNasaData { photoInfo in
            let title  = photoInfo.title
            
            guard let imageUrl = photoInfo.url else {
                let entry = SimpleEntry(date: Date(), title: title, image: placeHolderImage)
                let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(86400)))
                completion(timeline)
                return
            }
            
            URLSession.shared.dataTask(with: imageUrl) { data, reponse, error in
                var image: Image = self.placeHolderImage
                
                if let data = data, let uiImage = UIImage(data: data) {
                    image = Image(uiImage: uiImage)
                }
                
                let entry = SimpleEntry(date: Date(), title: title, image: image)
                let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(86400)))
                completion(timeline)
            }.resume()
        }
    }
    
    //Faz a busca dos dados com a api da nasa
    private func fetchNasaData(completion: @escaping (PhotoInfo) -> ()) {
        let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=MG6fwO61YjT7vVcs6Rl6kQabHJzzeRH9YpJ8ht9E")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(PhotoInfo()) // Retorna um PhotoInfo vazio em caso de erro
                return
            }
            
            do {
                let photoInfo = try JSONDecoder().decode(PhotoInfo.self, from: data)
                completion(photoInfo)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(PhotoInfo())
            }
        }.resume()
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let title: String
    let image: Image
}

struct WidgetEntryView : View {
    @ObservedObject var networkMonitor = NetworkMonitor()
    var entry: Provider.Entry
    
    var body: some View {
        GeometryReader { geometry in //Pega o tamanho certinho do container, o widget nesse cado
            ZStack(alignment: .bottomLeading) {
                if networkMonitor.isConnected {
                    entry.image
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                        
                    Text(entry.title)
                        .font(.headline)
                        .foregroundColor(.white)
                        .shadow(color: Color.black.opacity(0.8), radius: 3, x: 0, y: 1)
                        .padding(.leading, 12)
                        .padding(.bottom, 8)
                } else {
                    //código para o widget sem conexão com a internet
                    Image("cao_maior")
                        .resizable()
                        .scaledToFill() // teste com as imagens da ana
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .clipped()
            .cornerRadius(10)
        }.ignoresSafeArea()
    }
}

@main
struct MyWidget: Widget {
    let kind: String = "Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}
