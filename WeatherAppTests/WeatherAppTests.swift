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
        viewModel.refreshWeather()
        XCTAssertTrue(viewModel.isRefreshing)
    }

    func testCityChangeTriggersRefresh() {
        viewModel.city = "New York"
    }

    func testWeatherIconMapping() {
        viewModel.weather = mockWeatherData(icon: "someIcon")
        XCTAssertEqual(viewModel.weatherIcon, "ExpectedIconString")
    }

    func testTemperature() {
        viewModel.weather = mockWeatherData(temp: 20.5)
        XCTAssertEqual(viewModel.temperature, "20.5")
    }

    func testSearchCity() {
        viewModel.searchCity(name: "New York")
    }
}

