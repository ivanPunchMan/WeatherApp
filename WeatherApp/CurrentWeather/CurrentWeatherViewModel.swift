//
//  CurrentWeatherViewModel.swift
//  WeatherApp
//
//  Created by Иван Дурмашев on 20.05.2022.
//

import Foundation
import RxSwift
import RxRelay

protocol ICurrentWeatherViewModel {
    var error: BehaviorRelay<Error?> { get set }
}

struct CurrentWeatherViewModel {
    let date: String
    let temp: String
    var weatherType: String?
    let wind: String
    let humidity: String
    var error = BehaviorRelay<Error?>(value: nil)
    private var bag = DisposeBag()
}

extension CurrentWeatherViewModel {
    
    init(from currentWeatherDTO: Day?) {
        let tempC = currentWeatherDTO?.tempC ?? 0
        let wind = currentWeatherDTO?.windKph ?? 0
        let humidity = currentWeatherDTO?.humidity ?? 0
        let weatherType = currentWeatherDTO?.condition.text ?? ""
                
        self.date = DateConverter.showDayWithWeekDay(Date())
        self.temp = String(tempC)
        self.weatherType = weatherType
        self.wind = String(wind)
        self.humidity = String(humidity)
    }
}
