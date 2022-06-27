//
//  WeatherNoteViewModel.swift
//  WeatherApp
//
//  Created by Иван Дурмашев on 20.05.2022.
//

import Foundation

struct WeatherNoteViewModel {
    let town: String?
    let date: Date?
    let weatherType: WeatherType?
    let temperature: Int?
    let additionalInfo: String?
}
