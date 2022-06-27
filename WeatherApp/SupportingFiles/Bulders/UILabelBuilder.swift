//
//  UILabelBuilder.swift
//  WeatherApp
//
//  Created by Иван Дурмашев on 27.05.2022.
//

import UIKit

final class UILabelBuilder {
    private var label: UILabel

// MARK: - init
    init() {
        self.label = UILabel()
    }
}

// MARK: - methods
extension UILabelBuilder {
    func setText(_ text: String) -> UILabelBuilder {
        self.label.text = text
        return self
    }

    func setFont(_ font: UIFont?) -> UILabelBuilder {
        self.label.font = font
        return self
    }
    
    func setTextColor(_ color: UIColor) -> UILabelBuilder {
        self.label.textColor = color
        return self
    }

    func setTextAlignment(_ alignment: NSTextAlignment) -> UILabelBuilder {
        self.label.textAlignment = alignment
        return self
    }
    
    func setLineBreakMode(_ lineBreakMode: NSLineBreakMode) -> UILabelBuilder {
        self.label.lineBreakMode = lineBreakMode
        return self
    }
    
    func setNumberOfLines(_ number: Int) -> UILabelBuilder {
        self.label.numberOfLines = number
        return self
    }
    
    func setAdjustsFontSizeToFitWidth(_ bool: Bool) -> UILabelBuilder {
        self.label.adjustsFontSizeToFitWidth = bool
        return self
    }
    
    func setMinimumScaleFactor(_ scale: CGFloat) -> UILabelBuilder {
        self.label.minimumScaleFactor = scale
        return self
    }
    
    func setSizeToFit() -> UILabelBuilder {
        self.label.sizeToFit()
        return self
    }
    
    func setAccessibilityIdentifier(_ identifier: String) -> UILabelBuilder {
        self.label.accessibilityIdentifier = identifier
        return self
    }
    
    func build() -> UILabel { self.label }
}
