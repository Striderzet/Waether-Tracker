//
//  NetworkErrors.swift
//  Weather Tracker
//
//  Created by Tony Buckner on 11/20/24.
//

import Foundation

public enum NetworkError: Error, LocalizedError {
    case missingRequiredFields(String)
    case invalidParameters(operation: String, parameters: [Any])
    case badRequest
    case unauthorized
    case paymentRequired
    case forbidden
    case notFound
    case requestEntityTooLarge
    case unprocessableEntity
    case http(httpResponse: HTTPURLResponse, data: Data)
}
