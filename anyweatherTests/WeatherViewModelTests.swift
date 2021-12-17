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
        mockSessionManager.error = .invalidCityName
        viewModel.fetchForecasts(query: "equwh")
        XCTAssertTrue(viewModel.forecastRecords.isEmpty)
        XCTAssertNotNil(viewModel.error)
    }
    
    func test_transformOutputNotNil() {
        let sampleWeatherForecast = SampleData.sampleWeatherForecast
        let output = viewModel.transformData(forecast: sampleWeatherForecast)
        XCTAssertNotNil(output.date)
        XCTAssertNotNil(output.temporature)
        XCTAssertNotNil(output.pressure)
        XCTAssertNotNil(output.humidity)
        XCTAssertNotNil(output.description)
        XCTAssertNotNil(output.image)
        XCTAssertNotNil(output.accessibilityDetail)
    }
    
    func test_valueResetSuccessful() {
        viewModel.forecastRecords = [SampleData.sampleDisplayRecord]
        viewModel.searchText = "dsawq"
        viewModel.note = "This is a test note"
        viewModel.clearResult()
        XCTAssertTrue(viewModel.forecastRecords.isEmpty)
        XCTAssertTrue(viewModel.searchText.isEmpty)
        XCTAssertTrue(viewModel.note.isEmpty)
    }
}
