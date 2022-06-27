//
//  Items.swift
//  WeatherApp
//
//  Created by Иван Дурмашев on 07.06.2022.
//

import Foundation
import RxSwift
import RxRelay

class SharedInstance {
    static let sharedInstance = SharedInstance()
    var historyOfWeatherDTO = BehaviorRelay<HistoryOfWeatherDTO?>(value: nil)
}
