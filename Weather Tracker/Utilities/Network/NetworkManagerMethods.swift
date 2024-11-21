//
//  NetworkManagerMethods.swift
//  Weather Tracker
//
//  Created by Tony Buckner on 11/20/24.
//

import Foundation

struct NetworkManagerMethods {
    
    /// This method will parse and handle possible network errors from our async await network calls
    /// - Parameter response: The response that will need to be parsed to determine what error was sent back from the request
    /// - Returns: The requested data
    static func mapResponse(response: (data: Data, response: URLResponse)) throws -> Data {
        
        guard let httpResponse = response.response as? HTTPURLResponse else {
            return response.data
        }
        
        switch httpResponse.statusCode {
        case 200..<300:
            return response.data
        case 400:
            throw NetworkError.badRequest
        case 401:
            throw NetworkError.unauthorized
        case 402:
            throw NetworkError.paymentRequired
        case 403:
            throw NetworkError.forbidden
        case 404:
            throw NetworkError.notFound
        case 413:
            throw NetworkError.requestEntityTooLarge
        case 422:
            throw NetworkError.unprocessableEntity
        default:
            throw NetworkError.http(httpResponse: httpResponse, data: response.data)
        }
        
    }
    
}
