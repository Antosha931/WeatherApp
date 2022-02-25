//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Антон Титов on 10.02.2022.
//

import Foundation

struct NetworkManager {
    
    func jsonDataProcessing(forCity city: String, completion: @escaping (Result<CurrentWeather, Error>) -> Void) {
        
        let urlComponents: URLComponents = {
            var url = URLComponents()
            url.scheme = "https"
            url.host = "api.openweathermap.org"
            url.path = "/data/2.5/weather"
            url.queryItems = [
                URLQueryItem(name: "q", value: city),
                URLQueryItem(name: "lang", value: "ru"),
                URLQueryItem(name: "appid", value: SomeSingletone.shared.userAPIKey),
                URLQueryItem(name: "units", value: "metric")
            ]
            return url
        }()
        
        guard let url = urlComponents.url else { return }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                    
                    guard let currentWeather = CurrentWeather(weatherData: weatherData) else { return }
                    
                    completion(.success(currentWeather))
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}
