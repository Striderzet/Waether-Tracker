//
//  Weather_TrackerTests.swift
//  Weather TrackerTests
//
//  Created by Tony Buckner on 11/20/24.
//

import XCTest
@testable import Weather_Tracker

final class Weather_TrackerTests: XCTestCase {
    
    // MARK: - Test Cases
    
    func testWeatherGoodRequest() async throws {
        guard let requestResponse = HTTPURLResponse(url: URL(string: "test")!, statusCode: 200, httpVersion: "", headerFields: [:]) else { return }
        let networkManager = makeNetworkManagerSUT(response: requestResponse, weatherModel: mockWeatherModel)
        let weatherService = WeatherService(networkManager: networkManager)
        let viewModel = await WeatherViewModel(weatherService: weatherService)
        await viewModel.getSearchedWeather()
        let result = await viewModel.tempWeather
        
        XCTAssertTrue(result?.current.humidity == 15)
        XCTAssertTrue(result?.location.name == "New York City")
        XCTAssertTrue(result?.current.temp_f == 83)
        XCTAssertTrue(result?.current.uv == 3)
    }
    
    func testWeatherEmptyRequest() async throws {
        guard let requestResponse = HTTPURLResponse(url: URL(string: "test")!, statusCode: 200, httpVersion: "", headerFields: [:]) else { return }
        let networkManager = makeNetworkManagerSUT(response: requestResponse)
        let weatherService = WeatherService(networkManager: networkManager)
        let viewModel = await WeatherViewModel(weatherService: weatherService)
        await viewModel.getSearchedWeather()
        let result = await viewModel.tempWeather
        XCTAssertTrue(result == nil)
    }
    
    // MARK: - Network Error Tests
    
    func testWeatherBadRequest() async throws {
        guard let requestResponse = HTTPURLResponse(url: URL(string: "test")!, statusCode: 400, httpVersion: "", headerFields: [:]) else { return }
        let networkManager = makeNetworkManagerSUT(response: requestResponse)
        let weatherService = WeatherService(networkManager: networkManager)
        let viewModel = await WeatherViewModel(weatherService: weatherService)
        await viewModel.getSearchedWeather()
        let result = await viewModel.networkError == NetworkError.badRequest.localizedDescription
        XCTAssertTrue(result)
    }
    
    func testWeatherUnauthorizedRequest() async throws {
        guard let requestResponse = HTTPURLResponse(url: URL(string: "test")!, statusCode: 401, httpVersion: "", headerFields: [:]) else { return }
        let networkManager = makeNetworkManagerSUT(response: requestResponse)
        let weatherService = WeatherService(networkManager: networkManager)
        let viewModel = await WeatherViewModel(weatherService: weatherService)
        await viewModel.getSearchedWeather()
        let result = await viewModel.networkError == NetworkError.unauthorized.localizedDescription
        XCTAssertTrue(result)
    }
        
    func testWeatherPaymentRequiredRequest() async throws {
        guard let requestResponse = HTTPURLResponse(url: URL(string: "test")!, statusCode: 402, httpVersion: "", headerFields: [:]) else { return }
        let networkManager = makeNetworkManagerSUT(response: requestResponse)
        let weatherService = WeatherService(networkManager: networkManager)
        let viewModel = await WeatherViewModel(weatherService: weatherService)
        await viewModel.getSearchedWeather()
        let result = await viewModel.networkError == NetworkError.paymentRequired.localizedDescription
        XCTAssertTrue(result)
    }
        
    func testWeatherForbiddenRequest() async throws {
        guard let requestResponse = HTTPURLResponse(url: URL(string: "test")!, statusCode: 403, httpVersion: "", headerFields: [:]) else { return }
        let networkManager = makeNetworkManagerSUT(response: requestResponse)
        let weatherService = WeatherService(networkManager: networkManager)
        let viewModel = await WeatherViewModel(weatherService: weatherService)
        await viewModel.getSearchedWeather()
        let result = await viewModel.networkError == NetworkError.forbidden.localizedDescription
        XCTAssertTrue(result)
    }
        
    func testWeatherNotFoundRequest() async throws {
        guard let requestResponse = HTTPURLResponse(url: URL(string: "test")!, statusCode: 404, httpVersion: "", headerFields: [:]) else { return }
        let networkManager = makeNetworkManagerSUT(response: requestResponse)
        let weatherService = WeatherService(networkManager: networkManager)
        let viewModel = await WeatherViewModel(weatherService: weatherService)
        await viewModel.getSearchedWeather()
        let result = await viewModel.networkError == NetworkError.notFound.localizedDescription
        XCTAssertTrue(result)
    }
        
    func testWeatherRequestEntityTooLargeRequest() async throws {
        guard let requestResponse = HTTPURLResponse(url: URL(string: "test")!, statusCode: 413, httpVersion: "", headerFields: [:]) else { return }
        let networkManager = makeNetworkManagerSUT(response: requestResponse)
        let weatherService = WeatherService(networkManager: networkManager)
        let viewModel = await WeatherViewModel(weatherService: weatherService)
        await viewModel.getSearchedWeather()
        let result = await viewModel.networkError == NetworkError.requestEntityTooLarge.localizedDescription
        XCTAssertTrue(result)
    }
        
    func testWeatherUnprocessableEntityRequest() async throws {
        guard let requestResponse = HTTPURLResponse(url: URL(string: "test")!, statusCode: 422, httpVersion: "", headerFields: [:]) else { return }
        let networkManager = makeNetworkManagerSUT(response: requestResponse)
        let weatherService = WeatherService(networkManager: networkManager)
        let viewModel = await WeatherViewModel(weatherService: weatherService)
        await viewModel.getSearchedWeather()
        let result = await viewModel.networkError == NetworkError.unprocessableEntity.localizedDescription
        XCTAssertTrue(result)
    }
    
    // MARK: - Mock Test Data
    
    let mockWeatherModel = WeatherModel(location: WeatherLocation(name: "New York City"),
                                        current: WeatherCurrent(temp_c: 20,
                                                                temp_f: 83,
                                                                condition: WeatherCondition(text: "Cloudy",
                                                                                            icon: "cloudyIcon",
                                                                                            code: 0002),
                                                                humidity: 15,
                                                                uv: 3,
                                                                feelslike_c: 25,
                                                                feelslike_f: 90))

    // MARK: - Subject Under Test
    
    func makeNetworkManagerSUT(response: HTTPURLResponse,
                               weatherModel: WeatherModel? = nil) -> NetworkManagerProtocol {
        return StubNetworkManagerForWeather(response: response, weatherModel: weatherModel)
    }

}
