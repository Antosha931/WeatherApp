//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Антон Титов on 10.02.2022.
//

import Foundation

struct WeatherData: Codable {
    
    let name: String
    let weather: [Weather]
    let main: Main
    
    enum CodingKeys: String, CodingKey {
        case name
        case weather
        case main
    }
}

struct Weather: Codable {
    
    let id: Int
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case description
    }
}

struct Main: Codable {
    
    let temp, feelsLike: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
    }
}
