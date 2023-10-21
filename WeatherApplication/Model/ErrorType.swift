//
//  ErrorType.swift
//  WeatherApplication
//
//  Created by Safa on 21.10.2023.
//

import Foundation


enum ErrorType : Error {
    case someError(error : Error)
    case requestFailed (description : String)
    case invalidStatusCode (statusCode : Int)
    case invalidData
    case invalidJSONParse
    
    var description : String {
        switch  self {
        case let .someError(error):
            return "An error occured: \(error.localizedDescription)"
        case let .requestFailed(description):
            return "Request failed: \(description)"
        case let .invalidStatusCode(statusCode):
            return "An invalid status code: \(statusCode)"
        case .invalidData:
            return "Invalid data"
        case .invalidJSONParse:
            return "JSON parsing process failed"
        }
    }
}
