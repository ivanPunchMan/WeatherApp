//
//  WeatherDiaryPresenter.swift
//  WeatherApp
//
//  Created by Иван Дурмашев on 20.05.2022.
//

import Foundation

protocol IWeatherDiaryPresenter: AnyObject {
    func viewDidLoad(ui: IWeatherDiaryView)
}

final class WeatherDiaryPresenter {
 
//MARK: - private properties
    private weak var ui: IWeatherDiaryView?
    private var interactor: IWeatherDiaryInteractor?
    private var router: IWeatherDiaryRouter?

//MARK: - init
    init(interactor: IWeatherDiaryInteractor, router: IWeatherDiaryRouter) {
        self.interactor = interactor
        self.router = router
    }
}

//MARK: - IWeatherDiaryPresenter
extension WeatherDiaryPresenter: IWeatherDiaryPresenter {
    
    func viewDidLoad(ui: IWeatherDiaryView) {
        self.ui = ui
        
        self.interactor?.reformattedData(completion: { data in
            self.ui?.getData(data: data)
        })
        
        self.ui?.delegate.didSelectRowAt = { [weak self] index in
            guard let self = self else { return }
            self.router?.routeToEditNote(forIndexPath: index)
        }
        
        self.ui?.onNewNoteTapped = {
            self.router?.routeToNewNote()
        }
    }
}
