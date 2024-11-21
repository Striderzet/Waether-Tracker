//
//  ContentView.swift
//  Weather Tracker
//
//  Created by Tony Buckner on 11/20/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @StateObject var weatherViewModel: WeatherViewModel
    
    var body: some View {
        
        VStack {
            
            CustomSearchBar(searchQuery: $weatherViewModel.searchQuery,
                            action: {
                Task {
                    await weatherViewModel.getSearchedWeather()
                }
            })
            
            if weatherViewModel.searchQuery == "" {
                
                if weatherViewModel.weatherService.currentWeather != nil {
                    
                    WeatherView(weatherService: weatherViewModel.weatherService)
                    
                } else {
                    EmptyStateView()
                }
                
            } else if let temp = weatherViewModel.tempWeather {
                
                WeatherResultsCard(currentWeather: temp, action: {
                    weatherViewModel.saveWeather()
                })
                
            }
            
            Spacer()
        }
        .task {
            await weatherViewModel.loadSavedWeatherQuery()
        }
    }
}

#Preview {
    ContentView(weatherViewModel: WeatherViewModel(weatherService: WeatherService(networkManager: NetworkManager())))
}
