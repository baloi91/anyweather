//
//  WeatherView.swift
//  anyweather
//
//  Created by Loi Tran on 12/15/21.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(searchText: $viewModel.searchText)
                List(viewModel.weatherForcasts, id: \.date) { forecastInfo in
                    WeatherCell(forecastInfo: forecastInfo)
                }
            }
                .navigationBarTitle("Weather Forecast", displayMode: .inline)
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(viewModel: WeatherViewModel())
    }
}
