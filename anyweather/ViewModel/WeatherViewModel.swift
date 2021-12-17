//
//  WeatherViewModel.swift
//  anyweather
//
//  Created by Loi Tran on 12/15/21.
//

import Foundation
import SwiftUI
import Combine

final class WeatherViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var forecastRecords: [WFDisplayData] = []
    @Published var showingPopover = false
    @Published var textSize: CGFloat = 14
    @Published var showToast: Bool = false
    
    var note: String = ""
    var error: APIError?
    private var disposeBag = Set<AnyCancellable>()
    private var sessionManager: SessionManagerProtocol
    
    init(sessionManager: SessionManagerProtocol = SessionManager()) {
        self.sessionManager = sessionManager
        $searchText
            .debounce(for: 1.5,
                         scheduler: RunLoop.main)
            .sink(receiveValue: { value in
                self.forecastRecords.removeAll()
                if value.count > 2 {
                    self.fetchForecasts(query: value)
                }
            })
            .store(in: &disposeBag)
    }
    
    func fetchForecasts(query: String) {
        let params = WeatherParams(query: query)
        sessionManager.getWeatherData(params: params,
                                      completionHandler: { success, response in
            if success {
                let result = response as! WeatherResponse
                let weatherForecasts = result.list
                let tempRecords = weatherForecasts.map({ self.transformData(forecast: $0) })
                self.forecastRecords = tempRecords
                self.error = nil
            } else {
                self.error = (response as! APIError)
            }
            self.updateNote()
        })
    }
    
    func transformData(forecast: WeatherForecast) -> WFDisplayData {
        let dateStr = AppFormatter.formatIntToDate(forecast.date)
        let temporatureStr = AppFormatter.formatTemporature(forecast.temp.average)
        let imageStr = forecast.weather.first?.icon ?? "10d"
        let descriptionStr = forecast.weather.first?.description ?? "N/A"
        let accessibilityStr = """
        The weather forecast for \(dateStr): Average temporature is \(temporatureStr)°C, \
        the pressure is \(forecast.pressure), the humidity is \(forecast.humidity). Looks like the weather today is \(descriptionStr).
        """
        return WFDisplayData(
            date: dateStr,
            temporature: temporatureStr,
            pressure: "\(forecast.pressure)",
            humidity: "\(forecast.humidity)",
            image: imageStr,
            description: descriptionStr,
            accessibilityDetail: accessibilityStr
        )
    }
    
    func clearResult() {
        forecastRecords = []
        searchText = ""
        note = ""
    }
    
    func updateNote() {
        if error != nil {
            switch error {
            case .invalidCityName:
                note = "This city is not exist."
            case .networkIssue:
                note = "There was a network issue while fetching data."
            case .invalidJson:
                note = "There was an issue with the server data."
            default:
                note = ""
            }
            showToast = true
        } else {
            showToast = false
            note = ""
        }
    }
}
