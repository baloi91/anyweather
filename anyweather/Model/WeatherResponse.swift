//
//  OpenWeatherResponse.swift
//  anyweather
//
//  Created by Loi Tran on 12/15/21.
//

import Foundation
struct WeatherResponse: Codable {
    let cod: String
    let message: Double
    let cnt: Int
    let list: [WeatherForecast]
}
