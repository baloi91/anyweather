//
//  AppFormatter.swift
//  anyweather
//
//  Created by Loi Tran on 12/16/21.
//

import Foundation

final class AppFormatter {
    static func formatTemporature(_ value: Double) -> String {
        return String(format: "%.1f", value)
    }
    
    static func formatIntToDate(_ value: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(value))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy"
        return dateFormatter.string(from: date)
    }
}
