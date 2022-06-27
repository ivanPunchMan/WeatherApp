//
//  Font.swift
//  WeatherApp
//
//  Created by Иван Дурмашев on 20.05.2022.
//

import UIKit

enum AppFonts {
    case regular20
    case regular18
    case regular16
    case regular100
    case bold
    case bold24
    case bold28

    var font: UIFont? {
        switch self {
        case .regular20:
            return UIFont(name: "Overpass-Regular", size: 20)
        case .regular16:
            return UIFont(name: "Overpass-Regular", size: 16)
        case .regular18:
            return UIFont(name: "Overpass-Regular", size: 18)
        case .bold:
            return UIFont(name: "Overpass-Bold", size: 20)
        case .regular100:
            return UIFont(name: "Overpass-Regular", size: 100)
        case .bold24:
            return UIFont(name: "Overpass-Bold", size: 24)
        case .bold28:
            return UIFont(name: "Overpass-Bold", size: 28)
        }
    }
}
