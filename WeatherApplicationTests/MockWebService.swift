//
//  MockWebClient.swift
//  WeatherApplicationTests
//
//  Created by Safa on 22.10.2023.
//

import Foundation
@testable import WeatherApplication


final class MockWebService : Service, Mockable {
    
    func getWeatherData<T : Codable>(request : URLRequest, type: T.Type, completition: @escaping ((T?, ErrorType?) -> () )) {

         loadFromJSON(filename: "MockWeather", type: T.self) { (results, error) in
            completition(results, error)
        }
    }
    
    
}
