//
//  Weather.swift
//  WeatherApplication
//
//  Created by Safa on 1.09.2023.
//

import Foundation



struct WeatherJSON : Codable {
    
    var success : Bool
    var result : [Weather]
    var city : String
}


struct Weather : Codable {
    
    let status : String
    let degree : String
    let min : String
    let max : String
    let night : String
    let day : String
    let humidity : String
    let date : String
    let description : String
    let icon : String
}




