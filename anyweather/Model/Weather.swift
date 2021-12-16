//
//  Weather.swift
//  anyweather
//
//  Created by Loi Tran on 12/15/21.
//

import Foundation
struct Weather: Codable {
    let id: Int
    let main, description, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main, icon
        case description = "description"
    }
}
