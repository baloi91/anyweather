//
//  anyweatherApp.swift
//  anyweather
//
//  Created by Loi Tran on 12/15/21.
//

import SwiftUI

@main
struct anyweatherApp: App {
    var body: some Scene {
        WindowGroup {
            WeatherView(viewModel: WeatherViewModel())
        }
    }
}
