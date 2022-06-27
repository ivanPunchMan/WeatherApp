//
//  WeatherDiaryViewController.swift
//  WeatherApp
//
//  Created by Иван Дурмашев on 20.05.2022.
//

import UIKit

final class WeatherDiaryViewController: UIViewController {

//MARK: - private properties
    private var presenter: IWeatherDiaryPresenter?
    var customView = WeatherDiaryView()
    
//MARK: - init
    init(presenter: IWeatherDiaryPresenter) {
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
        self.setupNav()
        self.presenter?.viewDidLoad(ui: self.customView)
    }
}

//MARK: - private methods
private extension WeatherDiaryViewController {
    func setupNav() {
        let image = UIImage(named: "edit")

        let nav = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(self.onNewNoteTapped))
        nav.tintColor = .white
        self.navigationItem.setRightBarButton(nav, animated: false)
    }
    @objc func onNewNoteTapped() {
        self.customView.onNewNoteTapped?()
    }
}
