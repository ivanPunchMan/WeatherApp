//
//  WeatherNoteViewController.swift
//  WeatherApp
//
//  Created by Иван Дурмашев on 20.05.2022.
//

import UIKit

final class WeatherNoteViewController: UIViewController {
    private enum Texts {
        static let cityHeader = "City"
        static let dateHeader = "Date"
        static let weatherHeader = "Weather"
        static let tempHeader = "Temperature"
        static let additionalInfoHeader = "Additional info"
    }

    private enum Constraints {
        static let standartVerticalOffset = 24
        static let standartHorizontalInset = 30
        static let saveButtonHorizontalInset = 90
    }

    private let scrollView = UIScrollView()

    private let cityNoteTFView = NoteTextFieldView(settings: .init(header: Texts.cityHeader))
    private lazy var dateLabel = self.createLabel(text: Texts.dateHeader)
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker(frame: .zero)
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.locale = Locale(identifier: "en")
        return datePicker
    }()

    private lazy var weatherLabel = self.createLabel(text: Texts.weatherHeader)
    
    private lazy var weatherPickerView: UIPickerView = {
        let pickerView = UIPickerView(frame: .zero)
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return pickerView
    }()
    
    private let tempNoteTFView = NoteTextFieldView(settings: .init(header: Texts.tempHeader))
    private let additionalInfoNoteTFView = NoteTextFieldView(settings: .init(header: Texts.additionalInfoHeader))
    
    private lazy var saveButton = WeatherButton(settings: .init(imageName: nil, labelText: "Save", font: .bold28, tapHandler: {
        self.saveButtonTapped()
    }))
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImageView(image: UIImage(named: "background"))
        image.contentMode = .scaleAspectFill
        self.view.addSubview(image)
        image.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
}

extension WeatherNoteViewController {
    func displayData(_ vm: WeatherNoteViewModel) {
        let weather =  WeatherType.allCases.firstIndex(of: vm.weatherType ?? .sunny) ?? 0
        self.weatherPickerView.selectRow(weather, inComponent: 1, animated: false)
        self.datePicker.date = vm.date ?? Date.now
        self.cityNoteTFView.text = vm.town
        self.tempNoteTFView.text = String(describing: vm.temperature)
        self.additionalInfoNoteTFView.text = vm.additionalInfo
    }

    func saveData(_ vm: WeatherNoteViewModel) {
        let vmData = WeatherNoteViewModel(town: self.cityNoteTFView.text,
                                          date: self.datePicker.date,
                                          weatherType: WeatherType.allCases[self.weatherPickerView.selectedRow(inComponent: 1)],
                                          temperature: Int(self.tempNoteTFView.text ?? "0"),
                                          additionalInfo: self.additionalInfoNoteTFView.text)
    }
}

private extension WeatherNoteViewController {
    func setupUI() {
        self.view.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        self.scrollView.addSubview(self.cityNoteTFView)
        self.cityNoteTFView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constraints.standartVerticalOffset)
            make.trailing.leading.equalToSuperview().inset(Constraints.standartHorizontalInset)
        }
        
        self.scrollView.addSubview(self.dateLabel)
        self.dateLabel.snp.makeConstraints { make in
            make.top.equalTo(self.cityNoteTFView.snp.bottom).offset(Constraints.standartVerticalOffset)
            make.leading.equalToSuperview().offset(Constraints.standartHorizontalInset)
        }
        
        self.scrollView.addSubview(self.datePicker)
        self.datePicker.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
        self.datePicker.snp.makeConstraints { make in
            make.centerY.equalTo(self.dateLabel)
            make.trailing.equalToSuperview().offset(-Constraints.standartHorizontalInset)
            make.leading.equalTo(self.dateLabel.snp.trailing).priority(.low)
        }
    
        self.scrollView.addSubview(self.weatherLabel)
        self.weatherLabel.snp.makeConstraints { make in
            make.top.equalTo(self.dateLabel.snp.bottom).offset(Constraints.standartVerticalOffset)
            make.trailing.leading.equalToSuperview().inset(Constraints.standartHorizontalInset)
        }
    
        self.scrollView.addSubview(self.weatherPickerView)
        self.weatherPickerView.snp.makeConstraints { make in
            make.top.equalTo(self.weatherLabel.snp.bottom)
            make.trailing.leading.equalToSuperview().inset(Constraints.standartHorizontalInset)
        }
        
        self.scrollView.addSubview(self.tempNoteTFView)
        self.tempNoteTFView.snp.makeConstraints { make in
            make.top.equalTo(self.weatherPickerView.snp.bottom).offset(Constraints.standartVerticalOffset)
            make.trailing.leading.equalToSuperview().inset(Constraints.standartHorizontalInset)
        }
        
        self.scrollView.addSubview(self.additionalInfoNoteTFView)
        self.additionalInfoNoteTFView.snp.makeConstraints { make in
            make.top.equalTo(self.tempNoteTFView.snp.bottom).offset(Constraints.standartVerticalOffset)
            make.trailing.leading.equalToSuperview().inset(Constraints.standartHorizontalInset)
        }
        
        self.scrollView.addSubview(self.saveButton)
        self.saveButton.snp.makeConstraints { make in
            make.top.equalTo(self.additionalInfoNoteTFView.snp.bottom).offset(Constraints.standartVerticalOffset)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(Constraints.saveButtonHorizontalInset)
            make.bottom.equalToSuperview()
        }
    }

    func saveButtonTapped() {
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true)
        }
    }
}

private extension WeatherNoteViewController {
    func createLabel(text: String) -> UILabel {
        let label = UILabelBuilder()
            .setFont(AppFonts.bold28.font)
            .setTextColor(.white)
            .setText(text)
            .build()
        return label
    }
}

extension WeatherNoteViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(
            string: WeatherType.allCases[row].description,
            attributes: [
                NSAttributedString.Key.font: AppFonts.regular18.font as Any,
                NSAttributedString.Key.foregroundColor: Colors.white.value
            ]
        )
    }
}

extension WeatherNoteViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        WeatherType.allCases.count
    }
}
