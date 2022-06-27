//
//  WeatherType.swift
//  WeatherApp
//
//  Created by Иван Дурмашев on 20.05.2022.
//

import UIKit

enum WeatherType: CaseIterable {
    case cloudy
    case clearCloudy
    case cold
    case rain
    case foggy
    case hail
    case hot
    case isolatedThunderstroms
    case lightwind
    case mostlyCloudy
    case partlyCloudy
    case showers
    case sleet
    case snowFlurries
    case snow
    case sunny
    case thunderstroms
    case tornado

    var description: String {
        switch self {
        case .sunny: return "sunny"
        case .rain: return "rain"
        case .snow: return "snow"
        case .cloudy: return "cloudy"
        case .clearCloudy: return "clear cloudy"
        case .cold: return "cold"
        case .foggy: return "foggy"
        case .hail: return "hail"
        case .hot: return "hot"
        case .isolatedThunderstroms: return "isolated thunderstroms"
        case .lightwind: return "lightwind"
        case .mostlyCloudy: return "mostly cloudy"
        case .partlyCloudy: return "partly cloudy"
        case .showers: return "showers"
        case .sleet: return "sleet"
        case .snowFlurries: return "snow flurries"
        case .thunderstroms: return "thunderstroms"
        case .tornado: return "tornado"
        }
    }

    var image: UIImage? {
        WeatherAsset(weatherType: self).image
    }
}
