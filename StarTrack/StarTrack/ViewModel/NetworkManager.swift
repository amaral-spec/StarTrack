//
//  NetworkManager.swift
//  StarTrack
//
//  Created by Aluno 14 on 6/11/25.
//

import Foundation
import Combine
import SwiftUI


class NetworkManager: ObservableObject{
    @Published var date: Date = Date()
    @Published var photoInfo = PhotoInfo()
    @Published var image: UIImage? = nil
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        // cria a URL
        let url = URL(string: Constants.baseURL)!
        
        let fullURL = url.withQuery(["api_key": Constants.key])!
        print(fullURL.absoluteURL)
        
        $date.removeDuplicates()
            .map{
                self.createURL(forL: $0)
            }.flatMap{ (url) in
                URLSession.shared.dataTaskPublisher(for: url)
                    .map(\.data)
                    .decode(type: PhotoInfo.self, decoder: JSONDecoder())
                    .catch { (erro) in
                        Just(PhotoInfo())
                }
            }
            .receive(on: RunLoop.main)
            .assign(to: \.photoInfo, on: self)
            .store(in: &subscriptions)
        
        $photoInfo
            .filter { $0.url != nil}
            .map{ photoInfo -> URL in
                return photoInfo.url!
            }.flatMap{ (url) in
                URLSession.shared.dataTaskPublisher(for: url)
                    .map(\.data)
                    .catch({error in
                        return Just(Data())
                    })
            }.map{(out) -> UIImage? in
                UIImage(data: out)
            }
            .receive(on: RunLoop.main)
            .assign(to: \.image, on:self)
            .store(in: &subscriptions)
        
        //Buscar dados da api da nasa
    }
    
    func createURL(forL date: Date) -> URL{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: date)
        
        let url = URL(string: Constants.baseURL)!
        let fullURL = url.withQuery(["api_key" : Constants.key, "date" : dateString])!
        
        return fullURL
    }
}
