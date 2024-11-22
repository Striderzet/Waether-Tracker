//
//  ContentView.swift
//  Weather Tracker
//
//  Created by Tony Buckner on 11/20/24.
//

import SwiftUI

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
            
            AnyView(weatherViewModel
                .prioritizeView(weatherView: WeatherView(weatherService: weatherViewModel.weatherService as! WeatherService),
                                weatherResultsCard: WeatherResultsCard(currentWeather: weatherViewModel.tempWeather,
                                                                       action: { weatherViewModel.saveWeather() }),
                                emptyState: EmptyStateView())
            )
            
            Spacer()
        }
        .task {
            await weatherViewModel.loadSavedWeatherQuery()
        }
        .alert(isPresented: $weatherViewModel.presentErrorAlert, content: {
            weatherViewModel.errorAlert
        })
    }
}

#Preview {
    ContentView(weatherViewModel: WeatherViewModel(weatherService: WeatherService(networkManager: NetworkManager())))
}
