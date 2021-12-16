//
//  SampleData.swift
//  anyweather
//
//  Created by Loi Tran on 12/15/21.
//

import Foundation

struct SampleData {
    static let sampleTemporature: Temporature = Temporature(day: 30, min: 30, max: 20, night: 20, eve: 30, morn: 30)
    static let sampleWeather: Weather = Weather(id: 500, main: "Rain", description: "light rain", icon: "10d")
    static let sampleWeatherForecast: WeatherForecast = WeatherForecast(date: 1639540800,
                                                                        temp: sampleTemporature,
                                                                        pressure: 1010,
                                                                        humidity: 56,
                                                                        weather: [sampleWeather])
    static let sampleWeatherResponse: WeatherResponse = WeatherResponse(cod: "200", message: 0.0869257, cnt: 7, list: [sampleWeatherForecast])
    static let sampleIcon = APIEndpoint.imageBaseUrl + "10d@2x.png"
    static let sampleDisplayRecord: WFDisplayData = WFDisplayData(date: "20-12-2021",
                                                                  temporature: "20.4",
                                                                  pressure: "1024",
                                                                  humidity: "36.5",
                                                                  image: "10d",
                                                                  description: "N/A")
}
