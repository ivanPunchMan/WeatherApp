//
//  CurrentWeatherRouter.swift
//  WeatherApp
//
//  Created by Иван Дурмашев on 22.05.2022.
//

import Foundation
import UIKit

protocol ICurrentWeatherRouter: AnyObject {
    func openWeatherNote()
}

final class CurrentWeatherRouter {
    weak var vc: UIViewController?
}

//MARK: - ICurrentWeatherRouter
extension CurrentWeatherRouter: ICurrentWeatherRouter {
    func openWeatherNote() {
        self.vc?.present(WeatherNoteAssembly.build(), animated: true)
    }
}
