//
//  DateConverter.swift
//  WeatherApp
//
//  Created by Иван Дурмашев on 20.05.2022.
//

import Foundation

enum DateConverter {
    static func showDayWithWeekDay(_ date: Date) -> String {
        var result: String
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en")
        if self.isCurrentDate(date) {
            formatter.dateFormat = "d MMM"
            result = "Today, " + self.showShortDay(date)
        } else {
            formatter.dateFormat = "EE, d MMM"
            result = formatter.string(from: date)
        }
        return result
    }

    static func showShortDay(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en")
        formatter.dateFormat = "d MMM"
        return formatter.string(from: date)
    }
    
    static func getDateString(daysAgo: Int) -> String {
        let formatter = DateFormatter()
        let date = Calendar.current.date(byAdding: .day, value: daysAgo, to: Date.now) ?? Date.now
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }

    private static func isCurrentDate(_ date: Date) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MM YYYY"
        return formatter.string(from: Date.now) == formatter.string(from: date)
    }
}
