//
//  MenuHeaderView.swift
//  WeatherApp
//
//  Created by Kojo on 25/10/2023.
//

import SwiftUI

struct MenuHeaderView: View {
    @ObservedObject var cityViewModel: CityViewModel
    @State private var searchTerm = ""
    
    var body: some View {
        HStack {
            TextField("Search for a city...", onCommit: {
                cityViewModel.city = searchTerm
            })
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.1)))
            .foregroundColor(.white)
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 1))
            .padding(.leading, 20)
            
            Button(action: {
                cityViewModel.city = searchTerm
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue)
                    
                    Image(systemName: "location.fill")
                        .foregroundColor(.white)
                }
            }
            .frame(width: 50, height: 50)
        }
        .padding()
        .background(Color.blue.opacity(0.5))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}
