//
//  CityNameView.swift
//  WeatherApp
//
//  Created by Kojo on 25/10/2023.
//

import SwiftUI

struct CityNameView: View {
    var city: String
    var date: String
    
    var body: some View {
        HStack {
            VStack(alignment: .center, spacing: 10) {
                Text(city)
                    .font(.title)
                    .bold()
                Text(date)
            }.foregroundColor(.white)
        }
    }
}

//#Preview {
//    CityNameView()
//}
