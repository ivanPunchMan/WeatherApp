//
//  CurrentWeatherAssembly.swift
//  WeatherApp
//
//  Created by Иван Дурмашев on 20.05.2022.
//

enum CurrentWeatherAssembly {
    static func build() -> CurrentWeatherViewController {
        let networkService = NetworkService()
        let router = CurrentWeatherRouter()
        let presenter = CurrentWeatherPresenter(networkService: networkService, router: router)
        presenter.model = CurrentWeatherViewModel(from: nil)
        let vc = CurrentWeatherViewController(presenter: presenter)
        router.vc = vc
        
        return vc
    }
}
