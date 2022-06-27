//
//  CurrentWeatherPresenter.swift
//  WeatherApp
//
//  Created by Иван Дурмашев on 20.05.2022.
//

import Foundation
import RxSwift
import RxRelay

protocol ICurrentWeatherPresenter: AnyObject {
    var showError: ((Error) -> Void)? { get set}
    func viewDidLoad(ui: ICurrentWeatherView)
}

final class CurrentWeatherPresenter {
 
//MARK: - properties
    var model: CurrentWeatherViewModel?
    var showError: ((Error) -> Void)?
    weak var ui: ICurrentWeatherView?
    
    private var router: ICurrentWeatherRouter
    private var bag = DisposeBag()
    private var networkService: INetworkService
  
//MARK: - init
    init(networkService: INetworkService, router: ICurrentWeatherRouter) {
        self.networkService = networkService
        self.router = router
    }
}

//MARK: - ICurrentWeatherPresenter
extension CurrentWeatherPresenter: ICurrentWeatherPresenter {
    func viewDidLoad(ui: ICurrentWeatherView) {
        self.ui = ui
        
        self.ui?.onTapButtonHandler = { [weak self] in
            guard let self = self else { return }
            self.router.openWeatherNote()
        }
        
        self.subscribeToTheErrors()
        self.fetchHistoricalWeatherDataInCity()
    }
}

//MARK: - private methods
private extension CurrentWeatherPresenter {
    func fetchHistoricalWeatherDataInCity() {
        self.ui?.requestWeatherInCity = { [weak self] city in
            guard let self = self else { return }
            
            if let city = city, city != "" {
                self.fetchHistoricalWeatherData(from: city)
            } else {
                self.fetchHistoricalWeatherData(from: "Sankt Peterburg")
            }
        }
    }
    
    func fetchHistoricalWeatherData(from city: String) {        
        self.networkService.loadHistoricalWeatherData(city: city) { (result: Result<HistoryOfWeatherDTO, Error>) in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self.setCurrentWeatherData(from: model)
                    SharedInstance.sharedInstance.historyOfWeatherDTO.accept(model)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.model?.error.accept(error)
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func setCurrentWeatherData(from model: HistoryOfWeatherDTO) {
        guard let currentWeatherModel = model.forecast.forecastday.last?.day else { return }
        let imageURL = currentWeatherModel.condition.icon
        self.model = CurrentWeatherViewModel(from: currentWeatherModel)
        
        self.fetchImageDataFrom(url: imageURL)
        self.ui?.displayWeatherData(self.model)
    }
    
    func fetchImageDataFrom(url: String) {
        self.networkService.loadWeatherImage(urlString: url) { (result: Result<Data, Error>) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.ui?.setImage(imageData: data)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.model?.error.accept(error)
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func subscribeToTheErrors() {
        self.model?.error.asObservable().subscribe(onNext: { [weak self] value in
            guard let self = self, let value = value else { return }
            self.showError?(value)
        }).disposed(by: self.bag)
    }
}
