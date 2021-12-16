//
//  WeatherForecast.swift
//  anyweather
//
//  Created by Loi Tran on 12/15/21.
//

import Foundation
struct WeatherForecast: Codable {
    let date: Int
    let temp: Temporature
    let pressure, humidity: Int
    let weather: [Weather]

    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case temp
        case pressure, humidity, weather
    }
}

struct Temporature: Codable {
    let day, min, max, night, eve, morn: Double
    
    var average: Double {
        return [day, min, max, night, eve, morn].reduce(0, +)/6
    }
}

struct WFDisplayData {
    let date, temporature, pressure, humidity, image, description: String
}
