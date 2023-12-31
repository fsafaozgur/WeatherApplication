//
//  WeatherResult.swift
//  WeatherApplication
//
//  Created by Safa on 2.10.2023.
//

import Foundation

enum WeatherResult {
    case success(_ weather : [Weather])
    case failure(_ error : ErrorType)
}

