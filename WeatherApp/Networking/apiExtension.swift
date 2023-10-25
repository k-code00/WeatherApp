//
//  apiExtension.swift
//  WeatherApp
//
//  Created by Kojo on 24/10/2023.
//

import Foundation

extension API {
    static let baseURL = "https://api.openweathermap.org/data/2.5/"
    
    static func getURLFor(lat: Double, lon: Double) -> String {
        return "\(baseURL)onecall?lat=\(lat)&lon=\(lon)&exclude=minutely&appid=\(key)"
    }
}
