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
        
        VStack(spacing: AppConstants.Spacing.spacing8) {
            
            AnyView(ImageCache.showImage(withURL: weatherService.secureImageUrl()))
                .frame(width: AppConstants.Sizes.imageSize100, height: AppConstants.Sizes.imageSize100)
                .padding()
            
            HStack(spacing: AppConstants.Spacing.spacing8) {
                Text(weatherService.currentWeather?.location.name ?? "New York City")
                    .font(.largeTitle.bold())
                Image(systemName: AppConstants.SystemImageName.locationFill)
                    .resizable()
                    .frame(width: AppConstants.Sizes.imageSize20, height: AppConstants.Sizes.imageSize20)
            }
            
            Text(weatherService.currentTempF())
                .font(.system(size: AppConstants.Sizes.fontSize75).bold())
            
            HStack(spacing: AppConstants.Spacing.spacing24) {
                DetailBarElement(title: AppConstants.Strings.humidity, value: weatherService.currentHumidity())
                DetailBarElement(title: AppConstants.Strings.uv, value: weatherService.currentUv())
                DetailBarElement(title: AppConstants.Strings.feelsLike, value: weatherService.currentFeelsLikeF())
            }
            .background(RoundedRectangle(cornerRadius: AppConstants.Spacing.spacing12).fill(Color.superLightGrey))
            .padding()
            
        }
        .padding()
        
        Spacer()
        
    }
}

#Preview {
    WeatherView(weatherService: WeatherService(networkManager: NetworkManager()))
}
