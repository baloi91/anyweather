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
    @Published var note: String = ""
    @Published var forecastRecords: [WFDisplayData] = []
    var error: APIError?
    private var disposeBag = Set<AnyCancellable>()
    private var sessionManager: SessionManagerProtocol
    
    init(sessionManager: SessionManagerProtocol = SessionManager()) {
        self.sessionManager = sessionManager
        $searchText
            .debounce(for: 1.5,
                         scheduler: RunLoop.main)
            .sink(receiveValue: { value in
                self.forecastRecords = []
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
            DispatchQueue.main.async {
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
            }
        })
    }
    
    func transformData(forecast: WeatherForecast) -> WFDisplayData {
        return WFDisplayData(
            date: AppFormatter.formatIntToDate(forecast.date),
            temporature: AppFormatter.formatTemporature(forecast.temp.average),
            pressure: "\(forecast.pressure)",
            humidity: "\(forecast.humidity)",
            image: "\(forecast.weather.first?.icon ?? "10d")",
            description: "\(forecast.weather.first?.description ?? "N/A")"
        )
    }
    
    func clearResult() {
        forecastRecords = []
        searchText = ""
        note = ""
    }
    
    func updateNote() {
        if error == nil && forecastRecords.isEmpty {
            note = "Please input a valid city name"
        } else if error != nil {
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
        } else {
            note = ""
        }
    }
}
