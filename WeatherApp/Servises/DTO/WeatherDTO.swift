//
//  WeatherDTO.swift
//  WeatherApp
//
//  Created by Иван Дурмашев on 04.06.2022.
//

import Foundation

// MARK: - HistoryOfWeather
struct HistoryOfWeatherDTO: Codable {
    let location: Location
    let forecast: Forecast
}

// MARK: - Forecast
struct Forecast: Codable {
    let forecastday: [Forecastday]
}

// MARK: - Forecastday
struct Forecastday: Codable {
    let date: String
    let day: Day
}

// MARK: - Day
struct Day: Codable {
    let tempC: Double
    let windKph: Double
    let humidity: Int
    let condition: Condition

    private enum CodingKeys: String, CodingKey {
        case tempC = "avgtemp_c"
        case windKph = "maxwind_kph"
        case humidity = "avghumidity"
        case condition
    }
}

// MARK: - Condition
struct Condition: Codable {
    let icon: String
    let text: String
}

// MARK: - Location
struct Location: Codable {
    let name: String
}
