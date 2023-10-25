//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Kojo on 24/10/2023.
//

import Foundation

struct WeatherResponse: Decodable {
    var current: Weather
    var hourly: [Weather]
    var daily: [DailyWeather]
    
    init(current: Weather, hourly: [Weather], daily: [DailyWeather]) {
        self.current = current
        self.hourly = hourly
        self.daily = daily
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        current = try container.decode(Weather.self, forKey: .current)
        hourly = try container.decode([Weather].self, forKey: .hourly)
        daily = try container.decode([DailyWeather].self, forKey: .daily)
    }
    
    static func empty() -> WeatherResponse {
        return WeatherResponse(current: Weather(), hourly: [Weather](repeating: Weather(), count: 23), daily: [DailyWeather](repeating: DailyWeather(), count: 8))
    }
    
    enum CodingKeys: String, CodingKey {
        case current
        case hourly
        case daily
    }
}
