//
//  Mockable.swift
//  WeatherApplicationTests
//
//  Created by Safa on 22.10.2023.
//

import Foundation
@testable import WeatherApplication


//Her testimizde ayri bir JSON file kullanabilecegimiz icin genel bir protokol tanimlayip testlerimizi bu property ve fonksiyonlar ile yurutecegiz

protocol Mockable : AnyObject {
    var bundle : Bundle {get}
    func loadFromJSON <T : Codable> (filename : String, type : T.Type, completition: @escaping ((T?, ErrorType?) -> () ))
}


extension Mockable {
    var bundle : Bundle {
        return Bundle(for: type(of: self))
    }
    
    func loadFromJSON <T : Codable> (filename : String, type : T.Type, completition: @escaping ((T?, ErrorType?) -> () )){
        

        guard let path = bundle.url(forResource: filename, withExtension: "json") else {
            completition(nil, .invalidJSONParse)
            return
        }
        
        do {
            let data = try Data(contentsOf: path)
            let result = try JSONDecoder().decode(T.self, from: data)
            completition(result, nil)
        } catch {
            completition(nil, .invalidData)
        }
        
        
    }
}

