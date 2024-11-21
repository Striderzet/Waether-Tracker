//
//  WeatherResultsCard.swift
//  Weather Tracker
//
//  Created by Tony Buckner on 11/20/24.
//

import SwiftUI

struct WeatherResultsCard: View {
    
    var currentWeather: WeatherModel
    var action: () -> ()
    
    var body: some View {
        
        Button(action: {
            action()
        }, label: {
            
            HStack(spacing: 56) {
                
                VStack {
                    
                    Text(currentWeather.location.name)
                        .font(.title.bold())
                    
                    Text("\(currentWeather.current.temp_f, specifier: "%.0f")°")
                        .font(.system(size: 65).bold())
                    
                }
                .padding()
                
                AnyView(ImageCache.showImage(withURL: "https:\(currentWeather.current.condition.icon)"))
                    .frame(width: 100, height: 100)
                    .background(Color.superLightGrey)
                    .padding()
                
            }
            .background(RoundedRectangle(cornerRadius: 12).fill(Color.superLightGrey))
            .padding()
            
        })
        
    }
}

#Preview {
    WeatherResultsCard(currentWeather: WeatherModel(location: WeatherLocation(name: "NYC"), current: WeatherCurrent(temp_c: 25, temp_f: 92, condition: WeatherCondition(text: "Hot!", icon: "", code: 1234), humidity: 66, uv: 32, feelslike_c: 50, feelslike_f: 105)), action: { })
}
