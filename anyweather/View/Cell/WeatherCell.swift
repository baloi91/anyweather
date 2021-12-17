//
//  WeatherCell.swift
//  anyweather
//
//  Created by Loi Tran on 12/15/21.
//

import SwiftUI

struct WeatherCell: View {
    @State var forecastInfo: WFDisplayData
    @Binding var textSize: CGFloat
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    SText(text: "Date: \(forecastInfo.date)", textSize: $textSize)
                    SText(text: "Average Temporature: \(forecastInfo.temporature)°C", textSize: $textSize)
                    SText(text: "Pressure: \(forecastInfo.pressure)", textSize: $textSize)
                    SText(text: "Humidity: \(forecastInfo.humidity)%", textSize: $textSize)
                    SText(text: "Description: \(forecastInfo.description)", textSize: $textSize)
                }
                .padding()
                Spacer()
                CachedImage(imageName: forecastInfo.image)
                    .frame(width: 60, height: 60)
                    .padding(.horizontal, 20)
            }
            .accessibilityLabel(forecastInfo.accessibilityDetail)
            Divider()
        }
    }
}

struct SText: View {
    @State var text: String
    @Binding var textSize: CGFloat
    
    var body: some View {
        Text(text)
            .font(.system(size: textSize))
    }
}
