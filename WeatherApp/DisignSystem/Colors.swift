//
//  Colors.swift
//  WeatherApp
//
//  Created by Иван Дурмашев on 20.05.2022.
//

import UIKit

enum Colors {
    case white
    case whiteBackground
    case lightBlue
    case gray

    var value: UIColor {
        switch self {
        case .lightBlue:
            return UIColor(red: 0.514, green: 0.547, blue: 0.667, alpha: 1)
        case .white:
            return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        case .whiteBackground:
            return UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        case .gray:
            return UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        }
    }

    var cgColor: CGColor {
        return self.value.cgColor
    }
}
