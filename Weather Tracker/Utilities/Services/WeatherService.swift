//
//  WeatherService.swift
//  Weather Tracker
//
//  Created by Tony Buckner on 11/20/24.
//

import Foundation
import SwiftUI

final class WeatherService: ObservableObject {
    
    @Published var currentWeather: WeatherModel?
    
    private let networkManager: NetworkManagerProtocol
    
    private let savedWeatherQueryKey = "savedWeatherQueryKey"
    var savedWeatherQuery: String {
        get {
            if let savedWeather = UserDefaults.standard.string(forKey: savedWeatherQueryKey) {
                return savedWeather
            } else {
                return ""
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: savedWeatherQueryKey)
        }
    }
    
    init(currentWeather: WeatherModel? = nil, networkManager: NetworkManagerProtocol) {
        self.currentWeather = currentWeather
        self.networkManager = networkManager
    }
    
    @MainActor
    func fetchWeather(fromQuery query: String) async throws -> WeatherModel {
        return try await networkManager.fetchData(fromEndpoint: .getWeatherDetails(locationName: query),
                                                            toType: WeatherModel.self)
    }
    
    func storeSelectedWeatherSearch(_ selected: WeatherModel) {
        currentWeather = selected
        savedWeatherQuery = currentWeather?.location.name ?? ""
    }
    
    func secureImageUrl() -> String {
        return "https:\(currentWeather?.current.condition.icon ?? "")"
    }
    
    func currentTempF() -> LocalizedStringKey {
        return "\(currentWeather?.current.temp_f ?? 77, specifier: "%.0f")°"
    }
    
    func currentHumidity() -> LocalizedStringKey {
        return "\(currentWeather?.current.humidity ?? 55)%"
    }
    
    func currentUv() -> LocalizedStringKey {
        return "\(currentWeather?.current.uv ?? 10, specifier: "%.0f")"
    }
    
    func currentFeelsLikeF() -> LocalizedStringKey {
        return "\(currentWeather?.current.feelslike_f ?? 92, specifier: "%.0f")°"
    }
    
    func hasSavedQuery() -> Bool {
        return savedWeatherQuery != ""
    }
}
