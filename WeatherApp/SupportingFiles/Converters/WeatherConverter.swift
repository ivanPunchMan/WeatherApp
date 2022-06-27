//
//  WeatherConverter.swift
//  WeatherApp
//
//  Created by Иван Дурмашев on 20.05.2022.
//

enum WeatherConverter {
    static func convertTemperature(_ temperatureString: String) -> String {
        return temperatureString + "°"
    }

    static func convertWind(_ windString: String) -> String {
        return windString + " km/h"
    }

    static func convertHumidity(_ humidityString: String) -> String {
        return humidityString + " %"
    }
}
