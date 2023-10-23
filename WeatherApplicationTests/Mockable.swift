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
    //Testi hangi dizinde yapiyorsak onun dizin bilgisini aliyoruz
    var bundle : Bundle {
        return Bundle(for: type(of: self))
    }
    
    
    //Bu fonksiyon sayesinde, normalde uygulamanin internetten cektigi veriyi taklit ederek local bir JSON dosyasindan cekiyoruz
    func loadFromJSON <T : Codable> (filename : String, type : T.Type, completition: @escaping ((T?, ErrorType?) -> () )){
        
        let sem = DispatchSemaphore.init(value: 1)
        
        //Semophore aktif
        defer { sem.signal()}

        guard let path = bundle.url(forResource: filename, withExtension: "json") else {
            completition(nil, .invalidJSONParse)
            return
        }
        
        do {
            let data = try Data(contentsOf: path)
            let result = try JSONDecoder().decode(T.self, from: data)
            
            //Sonuclar donene kadar bekle
            sem.wait()
            completition(result, nil)
            
        } catch {
            completition(nil, .invalidData)
            
        }
        
    }
}

