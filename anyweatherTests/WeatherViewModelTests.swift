//
//  WeatherViewModelTests.swift
//  anyweatherTests
//
//  Created by Loi Tran on 12/16/21.
//

import XCTest
@testable import anyweather

class WeatherViewModelTests: XCTestCase {
    var viewModel: WeatherViewModel!
    var mockSessionManager: MockSessionManager!

    override func setUp() {
        mockSessionManager = MockSessionManager()
        viewModel = WeatherViewModel(sessionManager: mockSessionManager)
    }
    
    func test_fetchSuccessData() {
        mockSessionManager.stub = [SampleData.sampleWeatherForecast]
        viewModel.fetchForecasts(query: "saigon")
        XCTAssertTrue(!viewModel.weatherForcasts.isEmpty)
        XCTAssertNil(viewModel.error)
    }
    
    func test_fetchErrorWhenQueryRandomString() {
        mockSessionManager.stub = []
        mockSessionManager.error = .networkIssue
        viewModel.fetchForecasts(query: "equwh")
        XCTAssertTrue(viewModel.weatherForcasts.isEmpty)
        XCTAssertNotNil(viewModel.error)
    }
}
