//
//  CachingResponse.swift
//  anyweather
//
//  Created by Loi Tran on 12/16/21.
//

import Foundation

class CachingResponse {
    let key: String
    let createdAt: Date
    let data: WeatherResponse
    
    init(key: String, data: WeatherResponse) {
        self.key = key
        self.createdAt = Date()
        self.data = data
    }
}
