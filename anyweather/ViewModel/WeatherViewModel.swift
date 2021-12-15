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
    private var disposeBag = Set<AnyCancellable>()
    
    init() {
        $searchText
            .debounce(for: 2,
                         scheduler: RunLoop.main)
            .sink(receiveValue: { value in
                print(value)
            })
            .store(in: &disposeBag)
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
