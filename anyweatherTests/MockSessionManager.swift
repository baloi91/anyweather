//
//  MockSessionManager.swift
//  anyweatherTests
//
//  Created by Loi Tran on 12/16/21.
//

import Foundation
@testable import Any_Weather

final class MockSessionManager: SessionManagerProtocol {
    var stub: WeatherResponse?
    var error: APIError?
    
    func getWeatherData(params: WeatherParams, completionHandler: @escaping APICallCompletion) {
        if let error = error {
            completionHandler(false, error)
        } else {
            completionHandler(true, stub)
        }
    }
}
