//
//  WeatherModel.swift
//  TrainingApp
//
//  Created by Дария Григорьева on 17.01.2023.
//

import Foundation

struct WeatherModel: Decodable {
    let currently: Currently
}

struct Currently: Decodable {
    let temperature: Double
    let icon: String?
    
    var temperatureCelsius: Int {
        return (Int(temperature) - 32) * 5 / 9
    }
    
    var iconLocal: String {
        switch icon {
        case "clear-day": return "Clear-day"
        case "clear-night": return "Clear-night"
        case "rain": return "Rain"
        case "snow": return "Snow"
        case "sleet": return "Sleet"
        case "wind": return "Wind"
        case "fog": return "Fog"
        case "cloudy": return "Cloudy"
        case "partly-cloudy-day": return "Partly-cloudy-day"
        case "partly-cloudy-night": return "Partly-cloudy-night"
        default: return "No data"
        }
    }
    
    var description: String {
        switch icon {
        case "clear-day": return "Nice weather to work out outside"
        case "clear-night": return "Clear-night"
        case "rain": return "Rain"
        case "snow": return "Snow"
        case "sleet": return "Sleet"
        case "wind": return "Wind"
        case "fog": return "Fog"
        case "Cloudy": return "It's night and clouds outside! Train at home!"
        case "partly-cloudy-day": return "Partly-cloudy-day"
        case "partly-cloudy-night": return "Partly-cloudy-night"
        default: return "No data"
        }
    }
}
