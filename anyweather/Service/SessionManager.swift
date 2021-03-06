//
//  SessionManager.swift
//  anyweather
//
//  Created by Loi Tran on 12/15/21.
//

import Foundation
import Alamofire

typealias APICallCompletion = (_ success: Bool, _ responseObject: Any?) -> Void
enum APIError: Error {
    case invalidJson
    case networkIssue
    case invalidCityName
}

protocol SessionManagerProtocol {
    func getWeatherData(params: WeatherParams, completionHandler: @escaping APICallCompletion)
}

class SessionManager: SessionManagerProtocol {
    func getWeatherData(params: WeatherParams, completionHandler: @escaping APICallCompletion) {
        if let cacheResponse = CachingService.shared.getCacheData(for: params.query) {
            completionHandler(true, cacheResponse)
        } else {
            AF.request(APIEndpoint.baseUrl, parameters: params.dictionary)
                .validate()
                .responseData(queue: .global(), completionHandler: { response in
                    DispatchQueue.main.async {
                        switch response.result {
                        case .success(let data):
                            do {
                                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                                CachingService.shared.saveCacheData(for: params.query, value: weatherResponse)
                                completionHandler(true, weatherResponse)
                            } catch {
                                completionHandler(false, APIError.invalidJson)
                            }
                            
                        case .failure(let error):
                            if (error.responseCode == 404) {
                                completionHandler(false, APIError.invalidCityName)
                            } else {
                                completionHandler(false, APIError.networkIssue)
                            }
                        }
                    }
                })
        }
    }
}
