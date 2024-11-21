//
//  WeatherResultsCard.swift
//  Weather Tracker
//
//  Created by Tony Buckner on 11/20/24.
//

import SwiftUI

struct WeatherResultsCard: View {
    
    var currentWeather: WeatherModel?
    var action: () -> ()
    
    var body: some View {
        
        Button(action: {
            action()
        }, label: {
            
            HStack(spacing: AppConstants.Spacing.spacing56) {
                
                VStack {
                    
                    Text(currentWeather?.location.name ?? "NYC")
                        .font(.title.bold())
                        .foregroundStyle(Color.black)
                        .minimumScaleFactor(0.2)
                    
                    Text(AppConstants.Strings.temperatureWithDegree(currentWeather?.current.temp_f ?? 90))
                        .font(.system(size: AppConstants.Sizes.fontSize65).bold())
                        .foregroundStyle(Color.black)
                    
                }
                .padding()
                
                AnyView(ImageCache.showImage(withURL: AppConstants.Strings.secureUrl(currentWeather?.current.condition.icon ?? "")))
                    .background(Color.superLightGrey)
                    .frame(width: AppConstants.Sizes.imageSize100, height: AppConstants.Sizes.imageSize100)
                    .padding()
                
            }
            .background(RoundedRectangle(cornerRadius: AppConstants.Spacing.spacing12).fill(Color.superLightGrey))
            .padding()
            
        })
        
    }
}

#Preview {
    WeatherResultsCard(currentWeather: WeatherModel(location: WeatherLocation(name: "NYC"), current: WeatherCurrent(temp_c: 25, temp_f: 92, condition: WeatherCondition(text: "Hot!", icon: "", code: 1234), humidity: 66, uv: 32, feelslike_c: 50, feelslike_f: 105)), action: { })
}
