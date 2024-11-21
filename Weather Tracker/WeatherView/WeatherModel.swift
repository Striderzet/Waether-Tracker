//
//  WeatherModel.swift
//  Weather Tracker
//
//  Created by Tony Buckner on 11/20/24.
//

import Foundation

struct WeatherModel: Codable, Hashable {
    let location: WeatherLocation
    let current: WeatherCurrent
}

struct WeatherLocation: Codable, Hashable {
    let name: String
}

struct WeatherCurrent: Codable, Hashable {
    let temp_c: Double
    let temp_f: Double
    let condition: WeatherCondition
    let humidity: Int
    let uv: Double
    let feelslike_c: Double
    let feelslike_f: Double
}

struct WeatherCondition: Codable, Hashable {
    let text: String
    let icon: String
    let code: Int
}
