//
//  WeatherButton.swift
//  WeatherApp
//
//  Created by Иван Дурмашев on 20.05.2022.
//

import UIKit

class WeatherButton: UIView {
    struct Settings {
        let imageName: String?
        let labelText: String
        let font: AppFonts
        let tapHandler: () -> Void
    }

    private enum Constants {
        static let cornerRadius: CGFloat = 16
        static let borderWidth: CGFloat = 1
    }

    private enum Constraint {
        static let offset = 20
        static let labelImageHorizontalOffset = 12
    }

    private let tapHandler: () -> Void
    private var image: UIImage?
    
    private let label = UILabelBuilder()
        .setTextColor(.white)
        .build()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = self.image
        return imageView
    }()

    init(settings: Settings) {
        self.tapHandler = settings.tapHandler
        super.init(frame: .zero)
        self.configureUI(with: settings)
        self.configure()
        self.setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Кофигурируем нижний слой
private extension WeatherButton {
    func configure() {
        self.backgroundColor = Colors.whiteBackground.value
        self.layer.cornerRadius = Constants.cornerRadius
        self.layer.borderWidth = Constants.borderWidth
        self.layer.borderColor = Colors.white.cgColor
        self.layer.masksToBounds = true
    }
}

// MARK: - Добавляем констрейнты
private extension WeatherButton {
    func setupLayout() {
        if image != nil {
            self.setupLayoutWithImage()
        } else {
            self.setupLayoutWithoutImage()
        }
    }

    func setupLayoutWithImage(){
        self.imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Constraint.offset)
            make.leading.equalToSuperview().offset(Constraint.offset)
        }
        self.addSubview(self.label)
        self.label.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Constraint.offset)
            make.leading.equalTo(self.imageView.snp.trailing).offset(Constraint.labelImageHorizontalOffset)
            make.trailing.equalToSuperview().offset(-Constraint.offset)
        }
    }

    func setupLayoutWithoutImage(){
        self.addSubview(self.label)
        self.label.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Constraint.offset)
            make.leading.equalToSuperview().offset(Constraint.offset)
            make.trailing.equalToSuperview().offset(-Constraint.offset)
        }
        self.label.textAlignment = .center
    }
}

// MARK: - Добавляем настройки
private extension WeatherButton {
    func configureUI(with settings: Settings) {
        if let imageName = settings.imageName {
            self.image = UIImage(named: imageName)
        }
        self.label.text = settings.labelText
        self.label.font = settings.font.font

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.viewTapped))
        self.addGestureRecognizer(gestureRecognizer)
    }

    @objc
    func viewTapped() {
        self.tapHandler()
    }
}

