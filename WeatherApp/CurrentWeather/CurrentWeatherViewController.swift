//
//  CurrentWeatherViewController.swift
//  WeatherApp
//
//  Created by Иван Дурмашев on 20.05.2022.
//

import UIKit

final class CurrentWeatherViewController: UIViewController {

//MARK: - private properties
    private let customView = CurrentWeatherView()
    private var presenter: ICurrentWeatherPresenter?

//MARK: - init
    init(presenter: ICurrentWeatherPresenter) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//MARK: - loadView
    override func loadView() {
        self.view = self.customView
    }

//MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad(ui: self.customView)
        
        self.presenter?.showError = { [weak self] value in
            guard let self = self else { return }
            self.showAlertController(with: value.localizedDescription)
        }
        self.customView.requestWeather()
    }
    
    func showAlertController(with title: String) {
        DispatchQueue.main.async {
            if self.presentedViewController == nil, self.isViewLoaded, self.view.window != nil {
                let alert = UIAlertController(title: "Ошибка!", message: title, preferredStyle: .alert)
                let buttonOk = UIAlertAction(title: "Ок", style: .default)
                alert.addAction(buttonOk)
                self.present(alert, animated: true)
            }
        }
    }
}
