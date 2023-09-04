//
//  WebService.swift
//  WeatherApplication
//
//  Created by Safa on 1.09.2023.
//

import Foundation


class WebService {
    
    
    func getWeatherDatas(request : URLRequest, completition: @escaping (([Weather]?) -> () )) {
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            
            if error != nil {
                print(error?.localizedDescription)
                completition(nil)
            }else if let data = data {
 
                let weather = try? JSONDecoder().decode(WeatherJSON.self, from: data)
                
                if let weather = weather {
                    completition(weather.result)
                }
              
                
            }
        }.resume()
        
    }
}
