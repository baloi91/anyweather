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
    @Published var weatherForcasts: [WeatherForecast] = []
    @Published var searchText: String = ""
    @Published var error: APIError?
    private var disposeBag = Set<AnyCancellable>()
    private var sessionManager: SessionManagerProtocol
    
    init(sessionManager: SessionManagerProtocol = SessionManager()) {
        self.sessionManager = sessionManager
        $searchText
            .debounce(for: 1.5,
                         scheduler: RunLoop.main)
            .sink(receiveValue: { value in
                self.weatherForcasts = []
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
                self.weatherForcasts = result.list
                self.error = nil
            } else {
                self.error = (response as! APIError)
            }
        })
    }
    
    func clearResult() {
        weatherForcasts = []
    }
    
    func formatTemporature(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let temp = formatter.string(for: "\(value)")
        return temp ?? ""
    }
    
    func formatDate(_ value: Int) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter.string(from: Date(timeIntervalSince1970: TimeInterval(value)))
    }
}
