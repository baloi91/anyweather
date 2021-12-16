//
//  WeatherViewModelTests.swift
//  anyweatherTests
//
//  Created by Loi Tran on 12/16/21.
//

import XCTest
@testable import Any_Weather

class WeatherViewModelTests: XCTestCase {
    var viewModel: WeatherViewModel!
    var mockSessionManager: MockSessionManager!

    override func setUp() {
        mockSessionManager = MockSessionManager()
        viewModel = WeatherViewModel(sessionManager: mockSessionManager)
    }
    
    func test_fetchSuccessData() {
        mockSessionManager.error = nil
        mockSessionManager.stub = SampleData.sampleWeatherResponse
        viewModel.fetchForecasts(query: "saigon")
        XCTAssertTrue(!viewModel.forecastRecords.isEmpty)
        XCTAssertNil(viewModel.error)
    }
    
    func test_fetchErrorWhenQueryRandomString() {
        mockSessionManager.stub = nil
        mockSessionManager.error = .networkIssue
        viewModel.fetchForecasts(query: "equwh")
        XCTAssertTrue(viewModel.forecastRecords.isEmpty)
        XCTAssertNotNil(viewModel.error)
    }
    
    func test_transformOutputNotNil() {
        
    }
    
    func test_valueResetSuccessful() {
        
    }
}
