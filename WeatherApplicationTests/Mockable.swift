//
//  Mockable.swift
//  WeatherApplicationTests
//
//  Created by Safa on 22.10.2023.
//

import Foundation
@testable import WeatherApplication


//We can use different JSON files in all test scenarios so created a protocol
protocol Mockable : AnyObject {
    var bundle : Bundle {get}
    func loadFromJSON <T : Codable> (filename : String, type : T.Type, completition: @escaping ((T?, ErrorType?) -> () ))
}


extension Mockable {
    
    //automatically get the directory of JSON file that being used for test
    var bundle : Bundle {
        return Bundle(for: type(of: self))
    }

    
    //using local JSON file for pretending datas that normally being fetched from web
    func loadFromJSON <T : Codable> (filename : String, type : T.Type, completition: @escaping ((T?, ErrorType?) -> () )){


        guard let path = bundle.url(forResource: filename, withExtension: "json") else {
            completition(nil, .invalidData)
            return
        }
        
        do {
            let data = try Data(contentsOf: path)
            let result = try JSONDecoder().decode(T.self, from: data)
            completition(result, nil)
            
        } catch {
            completition(nil, .invalidJSONParse)
        }
        
    }
}

