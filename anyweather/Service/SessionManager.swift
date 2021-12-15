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
}

class SessionManager {
    static let shared: SessionManager = {
        let instance = SessionManager()
        return instance
    }()
    
    func getWeatherData(params: [String: Any], completionHandler: @escaping APICallCompletion) {
        AF.request(APIEndpoint.baseUrl, parameters: params)
            .validate()
            .responseData(completionHandler: { response in
                switch response.result {
                case .success(let data):
                    do {
                        let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                        completionHandler(true, weatherResponse)
                    } catch {
                        completionHandler(false, APIError.invalidJson)
                    }
                    
                case .failure(let error):
                    completionHandler(false, APIError.networkIssue)
                }
            })
    }
}
