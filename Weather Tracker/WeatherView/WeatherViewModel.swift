//
//  WeatherViewModel.swift
//  Weather Tracker
//
//  Created by Tony Buckner on 11/20/24.
//

import Foundation
import SwiftUI

@MainActor
class WeatherViewModel: ObservableObject {
    
    @Published var weatherService: WeatherService
    
    @Published var searchQuery = ""
    @Published var searchError = ""
    @Published var tempWeather: WeatherModel? = nil
    
    init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }
    
    func getSearchedWeather() async {
        do {
            tempWeather = try await weatherService.fetchWeather(fromQuery: searchQuery)
        } catch {
            print(AppConstants.ErrorMessages.searchError(error))
            searchError = AppConstants.ErrorMessages.searchError(error)
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
                searchError = AppConstants.ErrorMessages.savedWeatherError(error)
            }
        }
    }
    
    func saveWeather() {
        if let temp = tempWeather {
            weatherService.storeSelectedWeatherSearch(temp)
            tempWeather = nil
            searchQuery = ""
        }
    }
    
}
