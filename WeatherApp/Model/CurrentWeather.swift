//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Антон Титов on 10.02.2022.
//

import Foundation

struct CurrentWeather {
    
    let id: Int
    var systemIconNameString: String {
        switch id {
        case 200...232: return "cloud.bolt.rain.fill"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain.fill"
        case 600...622: return "cloud.snow.fill"
        case 701...781: return "smoke.fill"
        case 800: return "sun.max.fill"
        case 801...804: return "cloud.fill"
        default: return "nosign"
        }
    }
    
    let nameCity: String
    let temperature: Double
    var temperatureString: String {
        return String(format: "%.0f", temperature)
    }

    let weatherDescription: String
    
    let feelsLikeTemperature: Double
    var feelsLikeTemperatureString: String {
        let formatTemp = String(format: "%.0f", feelsLikeTemperature)
        return formatTemp + "℃"
    }
    
    init?(weatherData: WeatherData) {
        self.id = weatherData.weather.first!.id
        self.nameCity = weatherData.name
        self.weatherDescription = weatherData.weather.first!.description
        self.temperature = weatherData.main.temp
        self.feelsLikeTemperature = weatherData.main.feelsLike
    }
}
