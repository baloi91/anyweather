//
//  CachingService.swift
//  anyweather
//
//  Created by Loi Tran on 12/16/21.
//

import Foundation

class CachingService {
    
    static let shared: CachingService = {
        let instance = CachingService()
        return instance
    }()
    
    private let cache = NSCache<NSString, CachingResponse>()
    
    func getCacheData(for key: String) -> WeatherResponse? {
        let lowercasedKey = key.lowercased()
        if let cachedVersion = cache.object(forKey: NSString(string: lowercasedKey)) {
            let createdAt = cachedVersion.createdAt
            let validDate = Calendar.current.date(byAdding: .hour, value: -CachingConstant.durationInHour, to: Date())!
            if createdAt >= validDate {
                return cachedVersion.data
            }
        }
        return nil
    }
    
    func saveCacheData(for key: String, value: WeatherResponse) {
        let lowercasedKey = key.lowercased()
        let cacheData = CachingResponse(key: lowercasedKey, data: value)
        cache.setObject(cacheData, forKey: NSString(string: lowercasedKey))
    }
}
