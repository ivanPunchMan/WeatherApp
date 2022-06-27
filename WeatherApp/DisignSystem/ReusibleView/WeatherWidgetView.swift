//
//  WeatherWidgetView.swift
//  WeatherApp
//
//  Created by Иван Дурмашев on 20.05.2022.
//

import UIKit

class WeatherWidgetView: UIView {
    private enum Constraints {
        static let dateLabelTopOffset = 17
        static let separatorSectionTopOffset = 37
        static let separatorSectionHorisontalOffset = 77
        static let humBootomOffset = -25
    }
    private enum Constants {
        static let corner: CGFloat = 16
    }

    private let dateLabel = UILabelBuilder()
        .setNumberOfLines(1)
        .setAdjustsFontSizeToFitWidth(true)
        .setTextAlignment(.center)
        .setTextColor(.white)
        .setFont(AppFonts.regular18.font)
        .build()
    private let temperatureLabel = UILabelBuilder()
        .setNumberOfLines(1)
        .setAdjustsFontSizeToFitWidth(true)
        .setTextAlignment(.center)
        .setTextColor(.white)
        .setFont(AppFonts.regular100.font)
        .build()
    private let weatherDescribeLabel = UILabelBuilder()
        .setNumberOfLines(1)
        .setAdjustsFontSizeToFitWidth(true)
        .setTextAlignment(.center)
        .setTextColor(.white)
        .setFont(AppFonts.bold24.font)
        .setAccessibilityIdentifier("weatherDescribeLabel")
        .build()
    private let windView = SectionWithSeparatorView(type: .wind)
    private let humidityView = SectionWithSeparatorView(type: .humidity)

    init() {
        super.init(frame: .zero)
        self.configureView()
        self.setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func displayWeatherData(_ vm: CurrentWeatherViewModel) {
        self.dateLabel.text = vm.date
        self.temperatureLabel.text = vm.temp
        self.weatherDescribeLabel.text = vm.weatherType
        self.windView.displayData(vm.wind)
        self.humidityView.displayData(vm.humidity)
    }
}

private extension WeatherWidgetView {
    func configureView() {
        self.backgroundColor = Colors.whiteBackground.value
        self.layer.cornerRadius = Constants.corner
        self.layer.borderWidth = 2
        self.layer.borderColor = Colors.white.cgColor
        self.layer.masksToBounds = true
    }

    func setupLayout() {
        self.addSubview(self.dateLabel)
        self.dateLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(Constraints.dateLabelTopOffset)
            make.trailing.leading.equalToSuperview()
        }
        self.addSubview(self.temperatureLabel)
        self.temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(self.dateLabel.snp.bottom)
            make.trailing.leading.equalToSuperview()
        }
        self.addSubview(self.weatherDescribeLabel)
        self.weatherDescribeLabel.snp.makeConstraints { make in
            make.top.equalTo(self.temperatureLabel.snp.bottom)
            make.trailing.leading.equalToSuperview()
        }
        self.windView.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
        self.addSubview(self.windView)
        self.windView.snp.makeConstraints { make in
            make.width.lessThanOrEqualToSuperview().priority(.high)
            make.top.equalTo(self.weatherDescribeLabel.snp.bottom).offset(Constraints.separatorSectionTopOffset)
            make.centerX.equalToSuperview().priority(.high)
            make.trailing.lessThanOrEqualToSuperview().priority(.low)
            make.leading.lessThanOrEqualToSuperview().priority(.low)
        }
        self.humidityView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        self.addSubview(self.humidityView)
        self.humidityView.snp.makeConstraints { make in
            make.width.lessThanOrEqualToSuperview().priority(.high)
            make.top.equalTo(self.windView.snp.bottom)
            make.centerX.equalToSuperview().priority(.high)
            make.trailing.lessThanOrEqualToSuperview().priority(.low)
            make.leading.lessThanOrEqualToSuperview().priority(.low)
            make.bottom.equalTo(self).offset(Constraints.humBootomOffset)
        }
    }
}
