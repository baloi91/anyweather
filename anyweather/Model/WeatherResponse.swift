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

struct WeatherParams {
    var appId: String = "60c6fbeb4b93ac653c492ba806fc346d"
    var query: String = ""
    var numOfDays: Int = 7
    var units: String = "metric"
    
    var dictionary: [String: Any] {
        return [
            "appId": self.appId,
            "q": query,
            "cnt": numOfDays,
            "units": units
        ]
    }
}
