//
//  DailyView.swift
//  WeatherApp
//
//  Created by Kojo on 25/10/2023.
//

import SwiftUI

struct DailyView: View {
    @ObservedObject var cityViewModel: CityViewModel
    
    var body: some View {
        ForEach(cityViewModel.weather.daily) { weather in
            LazyVStack {
                dailyCell(weather: weather)
            }
        }
    }
    
    private func dailyCell(weather: DailyWeather) -> some View {
        HStack {
            Text(cityViewModel.getDayFor(timestamp: weather.dt) .uppercased())
                .frame(width:50)
            
            Spacer()
            
            Text("\(cityViewModel.getTempFor(temp: weather.temp.max)) | \(cityViewModel.getTempFor(temp: weather.temp.min))")
                .frame(width: 150)
            Spacer()
            cityViewModel.getWeatherIconFor(icon: weather.weather.count >  0 ? weather.weather[0].icon : "sun.max.fill")
        }
        .foregroundColor(.white)
        .padding(.horizontal, 40)
        .padding(.vertical, 15)
        //Add background properties -> gradient + shadows
    }
}

//#Preview {
//    DailyView()
//}
