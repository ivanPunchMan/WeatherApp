//
//  WeatherDiaryNoteCell.swift
//  WeatherApp
//
//  Created by Иван Дурмашев on 20.05.2022.
//

import UIKit

final class WeatherDiaryNoteCell: UITableViewCell {
    
    static let id = String(describing: WeatherDiaryNoteCell.self)

//MARK: - private enum
    private enum Constraint {
        static let topBottomInset = 18
        static let horizontalInset = 25
        static let horizontalSuperviewOffset = 16
        static let weatherImageViewSize = 48
        static let tempLabelWidth = 40
    }

//MARK: - private properties
    private let townLabel = UILabelBuilder()
        .setFont(AppFonts.bold24.font)
        .setTextAlignment(.left)
        .setTextColor(.white)
        .setAdjustsFontSizeToFitWidth(true)
        .build()
    
    private let dateLabel = UILabelBuilder()
        .setFont(AppFonts.regular20.font)
        .setTextAlignment(.center)
        .setTextColor(.white)
        .build()
    
    private let weatherImageView = UIImageView()
    
    private let tempLabel = UILabelBuilder()
        .setFont(AppFonts.regular20.font)
        .setTextAlignment(.right)
        .setTextColor(.white)
        .build()

//MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupLayot()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - internal method
extension WeatherDiaryNoteCell {
    func displayData(_ vm: WeatherDiaryEntity) {
        self.townLabel.text = vm.town
        self.dateLabel.text = vm.date
        self.weatherImageView.image = vm.weatherImage
        self.tempLabel.text = vm.temperature
    }
}

//MARK: - private method
private extension WeatherDiaryNoteCell {
    func setupLayot() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        self.contentView.addSubview(self.townLabel)
        self.townLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Constraint.topBottomInset)
            make.leading.equalToSuperview().offset(Constraint.horizontalSuperviewOffset)
            make.centerY.equalToSuperview().priority(.high)
        }
        self.contentView.addSubview(self.dateLabel)
        self.dateLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Constraint.topBottomInset)
            make.leading.equalTo(self.townLabel.snp.trailing).offset(Constraint.horizontalInset)
            make.centerY.equalToSuperview().priority(.high)
        }
        self.contentView.addSubview(self.weatherImageView)
        self.weatherImageView.snp.makeConstraints { make in
            make.leading.equalTo(self.dateLabel.snp.trailing).offset(Constraint.horizontalInset)
            make.width.height.equalTo(Constraint.weatherImageViewSize)
            make.top.bottom.equalToSuperview().inset(Constraint.topBottomInset)
            make.centerY.equalToSuperview().priority(.high)
        }
        self.tempLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        self.contentView.addSubview(self.tempLabel)
        self.tempLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.weatherImageView.snp.trailing).offset(Constraint.horizontalInset)
            make.top.bottom.equalToSuperview().inset(Constraint.topBottomInset)
            make.centerY.equalToSuperview().priority(.high)
            make.trailing.equalToSuperview().offset(-Constraint.horizontalSuperviewOffset)
            make.width.equalTo(Constraint.tempLabelWidth)
        }
    }
}
