//
//  WeatherDiaryDelegate.swift
//  WeatherApp
//
//  Created by Иван Дурмашев on 22.05.2022.
//

import Foundation
import UIKit

final class WeatherDiaryDelegate: NSObject {
    var didSelectRowAt: ((Int) -> Void)?
}

extension WeatherDiaryDelegate: UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.didSelectRowAt?(indexPath.row)
    }
}
