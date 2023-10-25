//
//  CityViewModel.swift
//  WeatherApp
//
//  Created by Kojo on 25/10/2023.
//

import Foundation
import SwiftUI
import CoreLocation

// View Model to manage and update the weather information for a city.
final class CityViewModel: ObservableObject {
    
    // Weather data for the city
    @Published var weather = WeatherResponse.empty()
    
    // Indicates if refresh is in progress
    @Published var isRefreshing: Bool = false
    
    // City name
    @Published var city: String = "" {
        didSet {
            refreshWeather()
        }
    }
    
    func refreshWeather() {
            isRefreshing = true
            getLocation()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.isRefreshing = false
            }
        }
    
    // DateFormatter for displaying the full date.
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
    
    // DateFormatter for displaying the day of the week.
    private lazy var dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }()
    
    // DateFormatter for displaying the hour of the day.
    private lazy var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh a"
        return formatter
    }()
    
    // Initializer
    init() {
        refreshWeather()
        getLocation()
    }
    
    // Computed property to get the date string.
    var date: String {
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.current.dt)))
    }
    
    // Computed property to get the weather icon string.
    var weatherIcon: String {
        if weather.current.weather.count > 0 {
            return weather.current.weather[0].icon
        }
        return "sun.max.fill"
    }
    
    // Computed property to get the temperature as a string.
    var temperature: String {
        return getTempFor(temp: weather.current.temp)
    }
    
    // Computed property to get the weather condition.
    var conditions: String {
        if weather.current.weather.count > 0 {
            return weather.current.weather[0].main
        }
        return ""
    }
    
    // Computed property to get the wind speed as a string.
    var windSpeed: String {
        return String(format: "%0.1f", weather.current.wind_speed)
    }
    
    // Computed property to get the humidity as a string.
    var humidity: String {
        return String(format: "%d%%", weather.current.humidity)
    }
    
    // Computed property to get the rain chances as a string.
    var rainChances: String {
        return String(format: "%0.0f%%", weather.current.dew_point)
    }
    
    // Function to get the time as a string from a timestamp.
    func getTimeFor(timestamp: Int) -> String {
        return timeFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
    // Function to get the temperature as a string.
    func getTempFor(temp: Double) -> String {
        return String(format: "%0.1f", temp)
    }
    
    // Function to get the day of the week as a string from a timestamp.
    func getDayFor(timestamp: Int) -> String {
        return dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
    // Function to get the location coordinates of a city.
    private func getLocation() {
        CLGeocoder().geocodeAddressString(city) { (placemarks, error) in
            if let places = placemarks, let place = places.first {
                self.getWeather(coord: place.location?.coordinate)
            }
        }
    }
    
    // Function to get the weather data for given coordinates.
    private func getWeather(coord: CLLocationCoordinate2D?) {
        if let coord = coord {
            let urlString = API.getURLFor(lat: coord.latitude, lon: coord.longitude)
            getWeatherInternal(city: city, for: urlString)
        } else {
            let urlString = API.getURLFor(lat: 37.5485, lon: -121.9886)
            getWeatherInternal(city: city, for: urlString)
        }
    }
    
    // Function to fetch weather data from a URL.
    private func getWeatherInternal(city: String, for urlString: String) {
        NetworkManager<WeatherResponse>.fetch(for: URL(string: urlString)!) { (result) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.weather = response
                }
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    // Function to get Lottie animation name for a weather icon.
    func getLottieAnimationFor(icon: String) -> String {
        switch icon {
        case "01d":
            return "clear-day"
        case "01n":
            return "clear-night"
        case "02d":
            return "cloudy"
        case "02n":
            return "cloudy"
        case "03d":
            return "overcast-day"
        case "03n":
            return "overcast-night"
        case "04d":
            return "overcast-day"
        case "04n":
            return "overcast-night"
        case "09d":
            return "raindrop"
        case "09n":
            return "raindrop"
        case "10d":
            return "raindrop"
        case "10n":
            return "raindrop"
        case "11d":
            return "thunderstorm-day"
        case "11n":
            return "thunderstorm-night"
        case "13d":
            return "overcast-day"
        case "13n":
            return "overcast-night"
        case "50d":
            return "overcast-day"
        case "50n":
            return "overcast-night"
        default:
            return "clear-day"
        }
    }
    
    // Function to get the weather icon for an icon string.
    func getWeatherIconFor(icon: String) -> Image {
        switch icon {
        case "01d":
            return Image(systemName: "sun.max.fill")
        case "01n":
            return Image(systemName: "moon.fill")
        case "02d":
            return Image(systemName: "cloud.sun.fill")
        case "02n":
            return Image(systemName: "cloud.moon.fill")
        case "03d":
            return Image(systemName: "cloud.fill")
        case "03n":
            return Image(systemName: "cloud.fill")
        case "04d":
            return Image(systemName: "cloud.fill")
        case "04n":
            return Image(systemName: "cloud.fill")
        case "09d":
            return Image(systemName: "cloud.drizzle.fill")
        case "09n":
            return Image(systemName: "cloud.drizzle.fill")
        case "10d":
            return Image(systemName: "cloud.heavyrain.fill")
        case "10n":
            return Image(systemName: "cloud.heavyrain.fill")
        case "11d":
            return Image(systemName: "cloud.bolt.fill")
        case "11n":
            return Image(systemName: "cloud.bolt.fill")
        case "13d":
            return Image(systemName: "cloud.snow.fill")
        case "13n":
            return Image(systemName: "cloud.snow.fill")
        case "50d":
            return Image(systemName: "cloud.fog.fill")
        case "50n":
            return Image(systemName: "cloud.fog.fill")
        default:
            return Image(systemName: "sun.max.fill")
        }
    }
}

extension CityViewModel {
    func searchCity(name: String) {
        CLGeocoder().geocodeAddressString(name) { (placemarks, error) in
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                return
            }
            if let places = placemarks, let place = places.first, let coord = place.location?.coordinate {
                self.getWeather(coord: coord)
            } else {
                print("Failed to get coordinates for city.")
                // Handle the error or fallback to a default coordinate
                self.getWeather(coord: nil)
            }
        }
    }
}


