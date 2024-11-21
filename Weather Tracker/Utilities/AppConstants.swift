//
//  AppConstants.swift
//  Weather Tracker
//
//  Created by Tony Buckner on 11/20/24.
//

import Foundation
import SwiftUI

struct AppConstants {
    
    struct Strings {
        static let humidity = "Humidity"
        static let uv = "UV"
        static let feelsLike = "Feels Like"
        static let searchLocation = "Search Location"
        static let noCitySelected = "No City Selected"
        static let searchForCity = "Please Search For A City"
        
        static func secureUrl(_ url: String) -> String {
            return "https:\(url)"
        }
        
        static func temperatureWithDegree(_ temperature: Double) -> LocalizedStringKey {
            return "\(temperature, specifier: "%.0f")°"
        }
        
    }
    
    struct SystemImageName {
        static let locationFill = "location.fill"
        static let magGlass = "magnifyingglass"
        static let rainbow = "rainbow"
    }
    
    struct Sizes {
        static let fontSize14: CGFloat = 14
        static let imageSize20: CGFloat = 20
        static let fontSize65: CGFloat = 65
        static let fontSize75: CGFloat = 75
        static let imageSize100: CGFloat = 100
    }
    
    struct Spacing {
        static let spacing8: CGFloat = 8
        static let spacing12: CGFloat = 12
        static let spacing24: CGFloat = 24
        static let spacing56: CGFloat = 56
    }
    
    struct Padding {
        static let padding200: CGFloat = 200
    }
    
    struct ErrorMessages {
        
        static func searchError(_ error: Error) -> String {
            return "There has been a search error: \(error)"
        }
        
        static func savedWeatherError(_ error: Error) -> String {
            return "There has been an error loading the saved weather query: \(error)"
        }
    }
    
}
