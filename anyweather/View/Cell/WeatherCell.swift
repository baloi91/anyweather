//
//  WeatherCell.swift
//  anyweather
//
//  Created by Loi Tran on 12/15/21.
//

import SwiftUI

struct WeatherCell: View {
    @State var forecastInfo: WeatherForecast
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Date: \(forecastInfo.date)")
                Text("Average Temporature: \(forecastInfo.temp.average)°C")
                Text("Pressure: \(forecastInfo.pressure)")
                Text("Humidity: \(forecastInfo.humidity)%")
                Text("Description: \(forecastInfo.weather.first!.description)")
            }
            .padding()
            Spacer()
            CachedImage(imageName: forecastInfo.weather.first!.icon)
                .frame(width: 60, height: 60)
                .padding(.horizontal, 20)
        }
    }
}

struct WeatherCell_Previews: PreviewProvider {
    static var previews: some View {
        WeatherCell(forecastInfo: SampleData.sampleWeatherForecast)
    }
}
