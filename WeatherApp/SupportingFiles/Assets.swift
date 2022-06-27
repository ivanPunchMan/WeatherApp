//
//  Assets.swift
//  WeatherApp
//
//  Created by Иван Дурмашев on 20.05.2022.
//

import UIKit

enum WeatherAsset: String, CaseIterable {
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

    init(weatherType: WeatherType) {
        switch weatherType {
        case .cloudy: self = .cloudy
        case .clearCloudy: self = .clearCloudy
        case .cold: self = .cold
        case .rain: self = .rain
        case .foggy: self = .foggy
        case .hail: self = .hail
        case .hot: self = .hot
        case .isolatedThunderstroms: self = .isolatedThunderstroms
        case .lightwind: self = .lightwind
        case .mostlyCloudy: self = .mostlyCloudy
        case .partlyCloudy: self = .partlyCloudy
        case .showers: self = .showers
        case .sleet: self = .sleet
        case .snowFlurries: self = .snowFlurries
        case .snow: self = .snow
        case .sunny: self = .sunny
        case .thunderstroms: self = .thunderstroms
        case .tornado: self = .tornado
        }
    }

    var image: UIImage? {
        return UIImage(named: self.imageName)
    }
}

private extension WeatherAsset {
    var imageName: String {
        switch self {
        case .cloudy: return "cloudy"
        case .clearCloudy: return "clear-cloudy"
        case .cold: return "cold"
        case .rain: return "drizzle"
        case .foggy: return "foggy"
        case .hail: return "hail"
        case .hot: return "hot"
        case .isolatedThunderstroms: return "isolated-thunderstroms"
        case .lightwind: return "lightwind"
        case .mostlyCloudy: return "mostly-cloudy"
        case .partlyCloudy: return "partly-cloudy"
        case .showers: return "showers"
        case .sleet: return "sleet"
        case .snowFlurries: return "snow-flurries"
        case .snow: return "snow"
        case .sunny: return "sunny"
        case .thunderstroms: return "thunderstroms"
        case .tornado: return "tornado"
        }
    }
}
