//
//  Weather.swift
//  WeatherApp
//
//  Created by Kojo on 24/10/2023.
//

import Foundation

struct Weather: Decodable, Identifiable {
    var dt: Int
    var temp: Double
    var feels_like: Double
    var pressure: Int
    var humidity: Int
    var dew_point: Double
    var clouds: Int
    var wind_speed: Double
    var wind_deg: Int
    var weather: [WeatherDetail]

    enum CodingKeys: String, CodingKey {
        case dt
        case temp
        case pressure
        case humidity
        case clouds
        case weather
        case feels_like
        case dew_point
        case wind_speed
        case wind_deg
    }
    
    init() {
        dt = 0
        temp = 0.0
        feels_like = 0.0
        pressure = 0
        humidity = 0
        dew_point = 0.0
        clouds = 0
        wind_speed = 0
        wind_deg = 0
        weather = []
    }
}

extension Weather {
    var id: UUID {
        return UUID()
    }
}

