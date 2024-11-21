//
//  NetworkConstants.swift
//  Weather Tracker
//
//  Created by Tony Buckner on 11/20/24.
//

import Foundation

enum URLConstants: String {
    case scheme = "https"
    case host = "api.weatherapi.com"
    case path = "/v1/"
    case apiKey = "current.json?key=9a53d932062843ba9f1152053242011"
}

enum APIEndpoint {
    
    case getWeatherDetails(locationName: String = "")
    
    var fullValueSuffix: String {
        switch self {
        case .getWeatherDetails(let locationName):
            return "\(URLConstants.apiKey.rawValue)&q=\(locationName)"
        }
    }
    
}
