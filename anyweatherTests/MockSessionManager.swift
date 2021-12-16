//
//  MockSessionManager.swift
//  anyweatherTests
//
//  Created by Loi Tran on 12/16/21.
//

import Foundation
@testable import anyweather

final class MockSessionManager: SessionManagerProtocol {
    var stub: [WeatherForecast] = []
    var error: APIError?
    
    func getWeatherData(params: WeatherParams, completionHandler: @escaping APICallCompletion) {
        if let error = error {
            completionHandler(false, error)
        }
        completionHandler(true, stub)
    }
}
