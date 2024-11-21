//
//  NetworkManager.swift
//  Weather Tracker
//
//  Created by Tony Buckner on 11/20/24.
//

import Combine
import Foundation
import SwiftUI

protocol NetworkManagerProtocol {
    func fetchData<T: Decodable>(fromEndpoint endpoint: APIEndpoint,
                                 toType type: T.Type) async throws -> T
}

class NetworkManager: NetworkManagerProtocol {
    
    /// With fetch data according to the API call selected (URL string here) and the data type selected
    /// - Parameters:
    ///   - urlString: "API call"
    ///   - type: Data model type
    /// - Returns: The requested data model parsed from the returned data if successful
    func fetchData<T: Decodable>(fromEndpoint endpoint: APIEndpoint,
                                 toType type: T.Type) async throws -> T {
        
        let url = constructURLComponents(endpoint: endpoint)
        let request = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: request)
        let fetchedData = try JSONDecoder().decode(T.self, from: try NetworkManagerMethods.mapResponse(response: (data, response)))
        return fetchedData
        
    }
    
    /// Construct the URL components for desired API calls
    /// - Parameter endpoint: Desired endpoint
    /// - Returns: Constructed URL
    private func constructURLComponents(endpoint: APIEndpoint) -> URL {
        
        var components = URLComponents()
        components.scheme = URLConstants.scheme.rawValue
        components.host = URLConstants.host.rawValue
        components.path = URLConstants.path.rawValue
        
        let completeURL = (components.url?.absoluteString ?? "")+endpoint.fullValueSuffix
        return URL(string: completeURL) ?? URL(fileURLWithPath: "")
        
    }
    
}
