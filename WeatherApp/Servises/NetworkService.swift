//
//  NetworkServise.swift
//  WeatherApp
//
//  Created by Иван Дурмашев on 04.06.2022.
//

import Foundation


protocol INetworkService: AnyObject {
    func loadHistoricalWeatherData<T: Decodable>(city: String, completion: @escaping (Result<T, Error>) -> Void)
    func loadWeatherImage(urlString: String, completion: @escaping(Result<Data, Error>) -> Void)
}

final class NetworkService {
   
//MARK: - private enums
    private enum EndPoint {
        static let currentWeatherURL = "https://api.weatherapi.com/v1/history.json?"
        
    }
    
    private enum QueryItem {
        static let key = URLQueryItem(name: "key", value: "b3a3f82138de4a3a9fe175841222405")
        static let startDate = URLQueryItem(name: "dt", value: DateConverter.getDateString(daysAgo: -7))
        static let endDate = URLQueryItem(name: "end_dt", value: DateConverter.getDateString(daysAgo: 0))
    }

//MARK: - private property
    private let session = URLSession.shared
}

//MARK: - INetworkService
extension NetworkService: INetworkService {
    
    func loadHistoricalWeatherData<T: Decodable>(city: String, completion: @escaping (Result<T, Error>) -> Void) {
        let url = self.getURL(param: city)
        let request = URLRequest(url: url)
        
        session.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func loadWeatherImage(urlString: String, completion: @escaping(Result<Data, Error>) -> Void) {
        let correctUrlString = "https:"+urlString
        guard let url = URL(string: correctUrlString) else { return }
        let request = URLRequest(url: url)
        session.downloadTask(with: request) { url, response, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let url = url else { return }
            if let data = try? Data(contentsOf: url) {
                completion(.success(data))
            }
        }.resume()
    }
}

//MARK: - private method
private extension NetworkService {
    func getURL(param city: String) -> URL {
        let queryItems = [
            QueryItem.key,
            QueryItem.startDate,
            QueryItem.endDate,
            URLQueryItem(name: "q", value: city),
        ]
        var urlComponents = URLComponents(string: EndPoint.currentWeatherURL)
        urlComponents?.queryItems = queryItems
        guard let url = urlComponents?.url else { assert(false, "Некорректный URL") }
        
        return url
    }
}

