//
//  CurrentWeatherView.swift
//  WeatherApp
//
//  Created by Иван Дурмашев on 21.05.2022.
//

import UIKit
import SnapKit

protocol ICurrentWeatherView: AnyObject {
    var onTapButtonHandler: (() -> Void)? { get set }
    var requestWeatherInCity: (((String?)) -> Void)? { get set }
    func requestWeather()
    func displayWeatherData(_ model: CurrentWeatherViewModel?)
    func setImage(imageData: Data)
}

final class CurrentWeatherView: UIView {
    
//MARK: - private enums
    private enum Constants {
        static let horisontalSearchOffset = 30
        static let searchHeight = 58
        static let emptyViewWidth = 16

        static let topImageViewOffset = 36
        static let imageViewSize = 142

        static let cornerRadius: CGFloat = 16
        static let widgetViewOffset = 36
        
        static let buttonTopOffset = 35
        static let buttonHorisontalOffset = 97
        static let weatherButtonImage = "edit"
    }

    private enum Texts {
        static let searchTFPlaceholder = "Search here"
        static let weatherButtonText = "New weather note"
    }
    
//MARK: - public properties
    var onTapButtonHandler: (() -> Void)?
    var requestWeatherInCity: (((String?)) -> Void)?
    
//MARK: - private properties
    private var attributedPlaceholder = NSAttributedString(string: Texts.searchTFPlaceholder,
                                                           attributes: [
                                                            NSAttributedString.Key.font: AppFonts.regular18.font as Any,
                                                            NSAttributedString.Key.foregroundColor: Colors.lightBlue.value
                                                           ])
    
    private let emptyView = UIView(frame: .init(x: .zero, y: .zero, width: Constants.emptyViewWidth, height: .zero))
    
    private lazy var searchTextField = UITextFieldBuilder()
        .setBackgroundColor(.white)
        .setCornerRadius(Constants.cornerRadius)
        .setMasksToBounds(true)
        .setAttributedPlaceholder(self.attributedPlaceholder)
        .setLeftViewMode(.always)
        .setLeftView(self.emptyView)
        .setRightViewMode(.always)
        .setRightView(self.emptyView)
        .setDelegate(self)
        .build()

    private let weatherIconImageView = UIImageView()
    
    private let weatherWidget = WeatherWidgetView()
    
    private lazy var newNoteButton = WeatherButton(settings: .init(imageName: Constants.weatherButtonImage,
                                                              labelText: Texts.weatherButtonText,
                                                              font: .regular16,
                                                                   tapHandler: { self.onTapButtonHandler?() }))
//MARK: - init
    init() {
        super.init(frame: .zero)
        let image = UIImageView(image: UIImage(named: "background"))
        image.contentMode = .scaleAspectFill
        
        self.addSubview(image)
        image.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.setupLayout()
        self.setAccessibilityIdentifier()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - ICurrentWeatherView
extension CurrentWeatherView: ICurrentWeatherView {
    func displayWeatherData(_ vm: CurrentWeatherViewModel?) {
        guard let vm = vm else { return }
        self.weatherWidget.displayWeatherData(vm)
    }
    
    func setImage(imageData: Data) {
        self.weatherIconImageView.image = UIImage(data: imageData)
    }
    
    func requestWeather() {
        self.requestWeatherInCity?(self.searchTextField.text)
    }
}

//MARK: - private methods
private extension CurrentWeatherView {
    
    func setupLayout() {
        self.addSubview(self.searchTextField)
        self.searchTextField.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(Constants.horisontalSearchOffset)
            make.height.equalTo(Constants.searchHeight)
        }
        
        self.weatherIconImageView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        self.weatherIconImageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        self.addSubview(self.weatherIconImageView)
        self.weatherIconImageView.snp.makeConstraints { make in
            make.top.equalTo(self.searchTextField.snp.bottom).offset(Constants.topImageViewOffset)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.weatherIconImageView.snp.height)
        }
        
        self.addSubview(self.weatherWidget)
        self.weatherWidget.snp.makeConstraints { make in
            make.top.equalTo(self.weatherIconImageView.snp.bottom).offset(Constants.topImageViewOffset)
            make.leading.trailing.equalToSuperview().inset(Constants.horisontalSearchOffset)
        }
        
        self.addSubview(self.newNoteButton)
        self.newNoteButton.snp.makeConstraints { make in
            make.top.equalTo(self.weatherWidget.snp.bottom).offset(Constants.buttonTopOffset)
            make.centerX.equalToSuperview()
            make.leading.lessThanOrEqualToSuperview().offset(Constants.buttonHorisontalOffset)
            make.trailing.lessThanOrEqualToSuperview().offset(-Constants.buttonHorisontalOffset).priority(.low)
            make.bottom.lessThanOrEqualTo(self.safeAreaLayoutGuide)
        }
    }
    func setAccessibilityIdentifier() {
        self.weatherIconImageView.accessibilityIdentifier = "weatherIconImageView"
    }
}

//MARK: - UITextFieldDelegate
extension CurrentWeatherView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.requestWeatherInCity?(textField.text)
        return true
    }
}
