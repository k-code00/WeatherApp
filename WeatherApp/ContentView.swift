//
//  ContentView.swift
//  WeatherApp
//
//  Created by Kojo on 24/10/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var cityViewModel = CityViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                MenuHeaderView(cityViewModel: cityViewModel)
                ScrollView(showsIndicators: false) {
                    CityView(cityViewModel: cityViewModel)
                }
            }.padding(.top, 30)
        }.background(LinearGradient(gradient: Gradient(colors: [Color(.blue), Color(.gray)]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .edgesIgnoringSafeArea(.all)
    }
}

//#Preview {
//    ContentView()
//}
