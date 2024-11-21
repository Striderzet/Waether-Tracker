//
//  Untitled.swift
//  Weather Tracker
//
//  Created by Tony Buckner on 11/20/24.
//

import Foundation
@testable import Weather_Tracker

struct StubNetworkManagerForWeather: NetworkManagerProtocol {
    
    var response: HTTPURLResponse
    var weatherModel: WeatherModel?
    
    func fetchData<T: Decodable>(fromEndpoint endpoint: APIEndpoint,
                                 toType type: T.Type) async throws -> T {
            if weatherModel == nil {
                let data = Data()
                let fetchedData = try JSONDecoder().decode(T.self, from: try NetworkManagerMethods.mapResponse(response: (data, response)))
                return fetchedData
            } else {
                return weatherModel as! T
            }
        }
    
}
