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
}



