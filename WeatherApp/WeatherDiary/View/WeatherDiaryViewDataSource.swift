//
//  WeatherDiaryViewDataSource.swift
//  WeatherApp
//
//  Created by Иван Дурмашев on 22.05.2022.
//

import UIKit

final class WeatherDiaryViewDataSource: NSObject {
    public var data = [WeatherDiaryEntity]()
}

extension WeatherDiaryViewDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: WeatherDiaryNoteCell.id, for: indexPath) as? WeatherDiaryNoteCell else { return UITableViewCell() }
        cell.displayData(self.data[indexPath.row])
        return cell
    }
}
