//
//  WeatherDiaryAssembly.swift
//  WeatherApp
//
//  Created by Иван Дурмашев on 20.05.2022.
//

import UIKit

enum WeatherDiaryAssembly {
    static func build() -> UIViewController {
        let interactor = WeatherDiaryInteractor()
        interactor.networkService = NetworkService()
        let router = WeatherDiaryRouter()
        let presenter = WeatherDiaryPresenter(interactor: interactor, router: router)
        let vc = WeatherDiaryViewController(presenter: presenter)
        router.vc = vc
        
        return vc
    }
}
