//
//  WebService.swift
//  WeatherApplication
//
//  Created by Safa on 1.09.2023.
//

import Foundation


class WebService {

    
    
    func getWeatherDatas(request : URLRequest, completition: @escaping ((WeatherResult) -> () )) {
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            

            if let error = error {
                completition(.failure(.someError(error : error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else{
                completition(.failure(.requestFailed(description : "Bad Http Request")))
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                completition(.failure(.invalidStatusCode(statusCode : httpResponse.statusCode)))
                return
            }
            
            guard let data = data  else {
                completition(.failure(.invalidData))
                return
            }
            
            do {
                let weather = try JSONDecoder().decode(WeatherJSON.self, from: data)
                completition(.success(weather.result))
            }catch {
                completition(.failure(.invalidJSONParse))
            }
            
                
        }.resume()
        
    }
    
    
    
    //Generic fonksiyon
    func getWeatherDataGeneric<T : Decodable>(request : URLRequest, type: T.Type, completition: @escaping ((T?) -> () )) {
        
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            

            if let error = error {
                completition(nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else{
                completition(nil)
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                completition(nil)
                return
            }
            
            guard let data = data  else {
                completition(nil)
                return
            }
            
            do {
                let weather = try JSONDecoder().decode(T.self, from: data)
                completition(weather)
            }catch {
                completition(nil)
            }
            
                
        }.resume()
        
       
    }
    
}



