//
//  WeatherResult.swift
//  WeatherApplication
//
//  Created by Safa on 2.10.2023.
//

import Foundation

//Ornek amacli yazdigimiz kodda kullandik, projemizde aktif olarak kullanilmamaktadir.
enum WeatherResult {
    case success(_ weather : [Weather])
    case failure(_ error : ErrorType)
    case None
}

