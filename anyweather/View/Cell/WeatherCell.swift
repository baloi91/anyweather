//
//  WeatherCell.swift
//  anyweather
//
//  Created by Loi Tran on 12/15/21.
//

import SwiftUI

struct WeatherCell: View {
    @State var forecastInfo: WFDisplayData
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Date: \(forecastInfo.date)")
                Text("Average Temporature: \(forecastInfo.temporature)°C")
                Text("Pressure: \(forecastInfo.pressure)")
                Text("Humidity: \(forecastInfo.humidity)%")
                Text("Description: \(forecastInfo.description)")
            }
            .padding()
            Spacer()
            CachedImage(imageName: forecastInfo.image)
                .frame(width: 60, height: 60)
                .padding(.horizontal, 20)
        }
    }
}

struct WeatherCell_Previews: PreviewProvider {
    static var previews: some View {
        WeatherCell(forecastInfo: SampleData.sampleDisplayRecord)
    }
}
