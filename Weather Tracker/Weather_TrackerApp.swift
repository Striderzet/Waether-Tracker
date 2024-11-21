//
//  Weather_TrackerApp.swift
//  Weather Tracker
//
//  Created by Tony Buckner on 11/20/24.
//

import SwiftUI
import SwiftData

@main
struct Weather_TrackerApp: App {
    
    @StateObject var weatherService = WeatherService(networkManager: NetworkManager())

    var body: some Scene {
        WindowGroup {
            ContentView(weatherViewModel: WeatherViewModel(weatherService: weatherService))
        }
    }
    
}
