//
//  SectionWithSeparatorView.swift
//  WeatherApp
//
//  Created by Иван Дурмашев on 20.05.2022.
//

import UIKit

class SectionWithSeparatorView: UIView {
    enum Atmosphere {
        case wind
        case humidity
        
        var desctiption: String {
            switch self {
            case .wind: return "Wind"
            case .humidity: return "Hum"
            }
        }

        var image: UIImage? {
            switch self {
            case .wind: return UIImage(named: "windy")
            case .humidity: return UIImage(named: "hum")
            }
        }
    }

    private enum Constraints {
        static let imageViewVericalOffSet = 5
    }

    private let imageView = UIImageView()
    private let nameLabel = UILabelBuilder()
        .setNumberOfLines(1)
        .setAdjustsFontSizeToFitWidth(true)
        .setMinimumScaleFactor(0.3)
        .setLineBreakMode(.byClipping)
        .setSizeToFit()
        .setTextAlignment(.center)
        .setTextColor(.white)
        .setFont(AppFonts.regular20.font)
        .build()
    private let separatorLabel = UILabelBuilder()
        .setNumberOfLines(1)
        .setTextAlignment(.center)
        .setTextColor(.white)
        .setText("|")
        .setFont(AppFonts.regular20.font)
        .build()
    private let dataLabel = UILabelBuilder()
        .setNumberOfLines(1)
        .setAdjustsFontSizeToFitWidth(true)
        .setTextAlignment(.left)
        .setTextColor(.white)
        .setFont(AppFonts.regular20.font)
        .build()
        
    init(type: Atmosphere) {
        super.init(frame: .zero)
        self.backgroundColor = .clear
        self.configureView(with: type)
        self.setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func displayData(_ value: String) {
        self.dataLabel.text = value
    }
}

private extension SectionWithSeparatorView {
    func configureView(with type: Atmosphere) {
        self.imageView.image = type.image
        self.nameLabel.text = type.desctiption
    }

    func setupLayout() {
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Constraints.imageViewVericalOffSet)
            make.leading.equalToSuperview()
        }
        self.addSubview(self.separatorLabel)
        self.separatorLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        self.nameLabel.setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)
        self.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Constraints.imageViewVericalOffSet)
            make.leading.equalTo(self.imageView.snp.trailing)
            make.trailing.equalTo(self.separatorLabel.snp.leading)
        }
        self.addSubview(self.dataLabel)
        self.dataLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Constraints.imageViewVericalOffSet)
            make.leading.equalTo(self.separatorLabel.snp.trailing)
            make.trailing.equalToSuperview()
        }
    }
}
