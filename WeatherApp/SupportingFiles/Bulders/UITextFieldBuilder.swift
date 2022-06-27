//
//  UITextFieldBuilder.swift
//  WeatherApp
//
//  Created by Иван Дурмашев on 27.05.2022.
//

import UIKit

final class UITextFieldBuilder {
    private var textField: UITextField

// MARK: - init
    init() {
        self.textField = UITextField()
    }
}

// MARK: - methods
extension UITextFieldBuilder {
    func setBackgroundColor(_ color: UIColor) -> UITextFieldBuilder {
        self.textField.backgroundColor = color
        return self
    }
    
    func setCornerRadius(_ cornerRadius: CGFloat) -> UITextFieldBuilder {
        self.textField.layer.cornerRadius = cornerRadius
        return self
    }

    func setBorderColor(_ color: UIColor) -> UITextFieldBuilder {
        self.textField.layer.borderColor = color.cgColor
        return self
    }

    func setBorderWidth(_ width: CGFloat) -> UITextFieldBuilder {
        self.textField.layer.borderWidth = width
        return self
    }
    
    func setText(_ text: String) -> UITextFieldBuilder {
        self.textField.text = text
        return self
    }
    
    func setMasksToBounds(_ bool: Bool) -> UITextFieldBuilder {
        self.textField.layer.masksToBounds = bool
        return self
    }
    
    func setAttributedPlaceholder(_ attributedString: NSAttributedString) -> UITextFieldBuilder {
        self.textField.attributedPlaceholder = attributedString
        return self
    }
    
    func setLeftView(_ view: UIView) -> UITextFieldBuilder {
        self.textField.leftView = view
        return self
    }
    
    func setLeftViewMode(_ mode: UITextField.ViewMode) -> UITextFieldBuilder {
        self.textField.leftViewMode = mode
        return self
    }
    
    func setRightView(_ view: UIView) -> UITextFieldBuilder {
        self.textField.rightView = view
        return self
    }
    
    func setRightViewMode(_ mode: UITextField.ViewMode) -> UITextFieldBuilder {
        self.textField.rightViewMode = mode
        return self
    }
    
    func setPlaceholder(_ placeholder: String) -> UITextFieldBuilder {
        self.textField.placeholder = placeholder
        return self
    }

    func setFont(_ font: UIFont) -> UITextFieldBuilder {
        self.textField.font = font
        return self
    }

    func setDelegate(_ delegate: UITextFieldDelegate) -> UITextFieldBuilder {
        self.textField.delegate = delegate
        return self
    }

    func build() -> UITextField { self.textField }
}
