//
//  Weather API.swift
//  StarTrack
//
//  Created by Aluno 14 on 6/17/25.
//

import Foundation

struct WeatherResponse: Codable {
    let weather: [Weather]
}

struct Weather: Codable {
    let main: String
}

func fetchWeather(latitude: Double, longitude: Double, completion: @escaping (String?) -> Void) {
    let apiKey = "f424f2b8e8e96408ab6c530755bdfe2d"
    let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
    
    guard let url = URL(string: urlString) else {
        completion(nil)
        return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data, error == nil else {
            completion(nil)
            return
        }
        
        do {
            let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
            completion(weatherResponse.weather.first?.main)
        } catch {
            completion(nil)
        }
    }.resume()
}
