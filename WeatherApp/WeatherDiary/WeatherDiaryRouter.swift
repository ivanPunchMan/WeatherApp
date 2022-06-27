//
//  WeatherDiaryRouter.swift
//  WeatherApp
//
//  Created by Иван Дурмашев on 20.05.2022.
//

import UIKit

protocol IWeatherDiaryRouter: AnyObject {
    func routeToNewNote()
    func routeToEditNote(forIndexPath: Int)
}

final class WeatherDiaryRouter {
    weak var vc: UIViewController?
}

//MARK: - IWeatherDiaryRouter
extension WeatherDiaryRouter: IWeatherDiaryRouter {
    func routeToNewNote() {
        let nextVC = WeatherNoteViewController()
        self.vc?.navigationController?.pushViewController(nextVC, animated: true)
        self.vc?.navigationController?.navigationBar.tintColor = .white
    }
    
    func routeToEditNote(forIndexPath: Int) {
        let nextVC = WeatherNoteViewController()
        self.vc?.present(nextVC, animated: true)
    }
}

