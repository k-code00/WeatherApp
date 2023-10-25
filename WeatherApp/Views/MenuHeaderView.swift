//
//  MenuHeaderView.swift
//  WeatherApp
//
//  Created by Consultant on 25/10/2023.
//

import SwiftUI

struct MenuHeaderView: View {
    @ObservedObject var cityViewModel: CityViewModel
    @State private var searchTerm = "Atlanta"
    
    var body: some View {
        HStack {
            TextField("", text: $searchTerm)
                .padding(.leading, 20)
            
            Button {
                cityViewModel.city = searchTerm
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue)
                    
                    Image(systemName: "location.fill")
                }
            }
            .frame(width: 50, height: 50)
        }
        .foregroundColor(.white)
        .padding()
        .background(ZStack (alignment: .leading) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.white)
                .padding(.leading, 10)
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.blue.opacity(0.5 ))
        })
    }
}

//#Preview {
//    MenuHeaderView()
//}
