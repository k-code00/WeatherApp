//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Kojo on 24/10/2023.
//

import XCTest
@testable import WeatherApp

class CityViewModelTests: XCTestCase {
    var lottieView: LottieView!
    var viewModel: CityViewModel!

    override func setUp() {
        super.setUp()
        lottieView = LottieView(name: "sampleAnimation")
        viewModel = CityViewModel()
    }

    override func tearDown() {
        lottieView = nil
        viewModel = nil
        super.tearDown()
    }

    func mockWeatherData(icon: String = "defaultIcon",
                         temp: Double = 25.0,
                         dt: Int = 0,
                         wind_speed: Double = 0.0,
                         humidity: Int = 0,
                         dew_point: Double = 0.0) -> WeatherResponse {
        
        let currentWeather = Weather()
        let hourlyWeather = [Weather](repeating: currentWeather, count: 23)
        let dailyWeather = [DailyWeather](repeating: DailyWeather(), count: 8)
        
        return WeatherResponse(current: currentWeather, hourly: hourlyWeather, daily: dailyWeather)
    }


    func testInitialization() {
        XCTAssertFalse(viewModel.isRefreshing)
        XCTAssertEqual(viewModel.city, "")
    }

    func testRefreshing() {
        XCTAssertFalse(viewModel.isRefreshing, "ViewModel should not be refreshing initially")
        viewModel.refreshWeather()
        XCTAssertTrue(viewModel.isRefreshing, "ViewModel should be refreshing after calling refreshWeather")
    }

    func testCityChangeTriggersRefresh() {
        let initialRefreshing = viewModel.isRefreshing
        viewModel.city = "New York"
        XCTAssertTrue(viewModel.isRefreshing && !initialRefreshing, "Changing city should trigger refreshing")
    }

    func testWeatherIconMapping() {
        let icon = "01d"
        viewModel.weather = mockWeatherData(icon: icon)
        XCTAssertEqual(viewModel.weatherIcon, "ExpectedIconStringFor01d")
    }

    func testTemperature() {
        viewModel.weather = mockWeatherData(temp: 20.5)
        XCTAssertEqual(viewModel.temperature, "20.5")
    }

    func testSearchCity() {
        viewModel.searchCity(name: "New York")
    }
}

