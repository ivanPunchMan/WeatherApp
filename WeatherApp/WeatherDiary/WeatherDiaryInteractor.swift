//
//  WeatherDiaryInteractor.swift
//  WeatherApp
//
//  Created by Иван Дурмашев on 20.05.2022.
//

import Foundation
import UIKit
import RxSwift

protocol IWeatherDiaryInteractor: AnyObject {
    func reformattedData(completion: @escaping ([WeatherDiaryEntity]) -> Void)
}

final class WeatherDiaryInteractor {
    var networkService: INetworkService?
    private var bag = DisposeBag()
}

//MARK: - IWeatherDiaryInteractor
extension WeatherDiaryInteractor: IWeatherDiaryInteractor {
    
    func reformattedData(completion: @escaping ([WeatherDiaryEntity]) -> Void) {
        
        SharedInstance.sharedInstance.historyOfWeatherDTO.asObservable().subscribe { value in
            let group = DispatchGroup()
            
            var entity = [WeatherDiaryEntity]()
            let currentWeatherDTO = value.element
            let historyOn7Days = currentWeatherDTO??.forecast.forecastday ?? [Forecastday]()
            
            let town = currentWeatherDTO??.location.name ?? ""
            let dates = historyOn7Days.map({ $0.date })
            let urlWeatherImages = historyOn7Days.map({ $0.day.condition.icon })
            let temperatures = historyOn7Days.map({ String($0.day.tempC) })
            
            for i in historyOn7Days.indices {
                group.enter()
                self.networkService?.loadWeatherImage(urlString: urlWeatherImages[i], completion: { result in
                    switch result {
                    case .success(let data):
                        DispatchQueue.main.async {
                            let image = UIImage(data: data) ?? UIImage()
                            entity.append(WeatherDiaryEntity(town: town, date: dates[i], weatherImage: image, temperature: temperatures[i]))
                            group.leave()
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            print(error.localizedDescription)
                            group.leave()
                        }
                    }
                })
            }
            group.notify(queue: DispatchQueue.main) {
                completion(entity)
            }
        }.disposed(by: self.bag)
    }
    
    func fetchWeatherImage(from url: String) -> UIImage {
        var image = UIImage()
        
        self.networkService?.loadWeatherImage(urlString: url, completion: { result in
            switch result {
            case .success(let data):
                image = UIImage(data: data) ?? UIImage()
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
        
        return image
    }
}
