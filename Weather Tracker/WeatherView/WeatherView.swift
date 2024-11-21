//
//  WeatherView.swift
//  Weather Tracker
//
//  Created by Tony Buckner on 11/20/24.
//

import SwiftUI

struct WeatherView: View {
    
    @ObservedObject var weatherService: WeatherService
    
    var body: some View {
        
        VStack(spacing: 8) {
            
            AnyView(ImageCache.showImage(withURL: weatherService.secureImageUrl()))
                .frame(width: 100, height: 100)
                .padding()
            
            HStack(spacing: 8) {
                Text(weatherService.currentWeather?.location.name ?? "New York City")
                    .font(.largeTitle.bold())
                Image(systemName: "location.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            
            Text(weatherService.currentTempF())
                .font(.system(size: 75).bold())
            
            HStack(spacing: 24) {
                DetailBarElement(title: "Humidity", value: weatherService.currentHumidity())
                DetailBarElement(title: "UV", value: weatherService.currentUv())
                DetailBarElement(title: "Feels Like", value: weatherService.currentFeelsLikeF())
            }
            .background(RoundedRectangle(cornerRadius: 12).fill(Color.superLightGrey))
            .padding()
            
        }
        .padding()
        
        Spacer()
        
    }
}

#Preview {
    WeatherView(weatherService: WeatherService(networkManager: NetworkManager()))
}
