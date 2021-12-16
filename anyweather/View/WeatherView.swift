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
            VStack(alignment: .leading) {
                SearchBar(viewModel: viewModel)
                WeatherBodyView(viewModel: viewModel)
            }
            .navigationBarTitle("Weather Forecast", displayMode: .inline)
            .onAppear {
                viewModel.updateNote()
            }
        }
    }
}

struct WeatherBodyView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    if !viewModel.note.isEmpty {
                        VStack {
                            Text(viewModel.note)
                        }
                    }
                    else {
                        LazyVStack {
                            ForEach(viewModel.forecastRecords, id: \.date) { forecastInfo in
                                WeatherCell(forecastInfo: forecastInfo)
                            }
                        }
                    }
                }
                .padding(.vertical)
                .frame(width: geometry.size.width)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(viewModel: WeatherViewModel())
    }
}
