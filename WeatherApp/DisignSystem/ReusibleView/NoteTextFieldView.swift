//
//  NoteTextFieldView.swift
//  WeatherApp
//
//  Created by Иван Дурмашев on 20.05.2022.
//

import UIKit

final class NoteTextFieldView: UIView {
    struct Settings {
        let header: String
        let value: String?

        init(header: String, value: String? = nil) {
            self.header = header
            self.value = value
        }
    }
    
    private enum Texts {
        static let placeholder = "Start typing here"
    }
    private enum Constraints {
        static let topOffset = 8
    }
    private enum Constants {
        static let corner: CGFloat = 16
        static let emptyViewWidth = 16
        static let tfHeight = 40
        static let borderWidth: CGFloat = 1
    }

    public var text: String?  {
        get {
            return self.textField.text
        }
        set {
            self.textField.text = newValue
        }
    }

    public var delegate: UITextFieldDelegate? {
        get {
            return nil
        }
        set {
            self.textField.delegate = newValue
        }
    }

    private let label = UILabelBuilder()
        .setFont(AppFonts.bold28.font)
        .setText(Texts.placeholder)
        .setTextColor(.white)
        .build()
    private let attributedPlaceholder = NSAttributedString(string: Texts.placeholder,
                                                   attributes: [NSAttributedString.Key.font: AppFonts.regular16.font as Any,
                                                                NSAttributedString.Key.foregroundColor: Colors.gray.value
                                                               ])
    private let emptyView = UIView(frame: .init(x: .zero, y: .zero, width: Constants.emptyViewWidth, height: .zero))
    private lazy var textField = UITextFieldBuilder()
            .setBackgroundColor(Colors.whiteBackground.value)
            .setCornerRadius(Constants.corner)
            .setBorderWidth(Constants.borderWidth)
            .setBorderColor(Colors.white.value)
            .setAttributedPlaceholder(self.attributedPlaceholder)
            .setLeftViewMode(.always)
            .setLeftView(self.emptyView)
            .setRightViewMode(.always)
            .setRightView(self.emptyView)
            .build()

    init(settings: Settings) {
        super.init(frame: .zero)
        self.setupUI()
        self.configureView(with: settings)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension NoteTextFieldView {
    func setupUI() {
        self.addSubview(self.label)
        self.label.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
        }
        self.addSubview(self.textField)
        self.textField.snp.makeConstraints { make in
            make.top.equalTo(self.label.snp.bottom).offset(Constraints.topOffset)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(Constants.tfHeight)
        }
    }

    func configureView(with settings: Settings) {
        self.label.text = settings.header
        self.textField.text = settings.value
    }
}
