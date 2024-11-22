//
//  WeatherViewModel.swift
//  Weather Tracker
//
//  Created by Tony Buckner on 11/20/24.
//

import Foundation
import SwiftUI

protocol WeatherViewModelProtocol {
    
    var networkError: String { get set }
    
    func getSearchedWeather() async
    func hasWeather() -> Bool
    func loadSavedWeatherQuery() async
    func saveWeather()
    func prioritizeView<v1: View, v2: View, v3: View>(weatherView: v1, weatherResultsCard: v2, emptyState: v3) -> any View
    
}

@MainActor
class WeatherViewModel: @preconcurrency WeatherViewModelProtocol, ObservableObject {
    
    @Published var weatherService: WeatherServiceProtocol
    
    @Published var searchQuery = ""
    @Published var networkError = ""
    @Published var presentErrorAlert = false
    let errorAlert = Alert(title: Text(AppConstants.Strings.error), message: Text(AppConstants.ErrorMessages.weatherError))
    
    @Published var tempWeather: WeatherModel? = nil
    
    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
    }
    
    func getSearchedWeather() async {
        do {
            tempWeather = try await weatherService.fetchWeather(fromQuery: searchQuery)
        } catch {
            print(AppConstants.ErrorMessages.searchError(error))
            networkError = error.localizedDescription
            presentErrorAlert = true
        }
    }
    
    func hasWeather() -> Bool {
        weatherService.hasSavedQuery()
    }
    
    func loadSavedWeatherQuery() async {
        if weatherService.hasSavedQuery() {
            do {
                weatherService.currentWeather = try await weatherService.fetchWeather(fromQuery: weatherService.savedWeatherQuery)
            } catch {
                print(AppConstants.ErrorMessages.savedWeatherError(error))
                networkError = error.localizedDescription
                presentErrorAlert = true
            }
        }
    }
    
    func saveWeather() {
        if let temp = tempWeather {
            weatherService.storeSelectedWeatherSearch(temp)
            withAnimation {
                tempWeather = nil
                searchQuery = ""
            }
        }
    }
    
    func prioritizeView<v1: View, v2: View, v3: View>(weatherView: v1, weatherResultsCard: v2, emptyState: v3) -> any View {
        
        return VStack {
            if searchQuery == "" {
                if weatherService.currentWeather != nil {
                    weatherView
                } else {
                    emptyState
                }
            } else if tempWeather != nil {
                weatherResultsCard
            }
        }
        
    }
    
}
