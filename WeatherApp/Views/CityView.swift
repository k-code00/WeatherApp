//
//  CityView.swift
//  WeatherApp
//
//  Created by Kojo on 25/10/2023.
//

import SwiftUI

struct CityView: View {
    @ObservedObject var cityViewModel: CityViewModel
    
    var body: some View {
        VStack  {
            CityNameView(city: cityViewModel.city, date: cityViewModel.date)
                .shadow(radius: 0)
            TodayView(cityViewModel: cityViewModel)
                .padding()
            HourlyView(cityViewModel: cityViewModel)
            DailyView(cityViewModel: cityViewModel)
        }.padding(.bottom, 30)
    }
}

//#Preview {
//    CityView()
//}
