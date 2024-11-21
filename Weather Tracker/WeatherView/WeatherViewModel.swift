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
            print("There has been a search error: \(error)")
            searchError = error.localizedDescription
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
                print("There has been an error loading the saved weather query: \(error)")
                searchError = error.localizedDescription
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
