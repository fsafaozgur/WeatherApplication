//
//  WebService.swift
//  WeatherApplication
//
//  Created by Safa on 1.09.2023.
//

import Foundation


protocol Service {
    func getWeatherData<T : Codable>(request : URLRequest, type: T.Type, completition: @escaping ((T?, ErrorType?) -> () ))
    
}

class WebService : Service {
    

    func getWeatherData<T : Codable>(request : URLRequest, type: T.Type, completition: @escaping ((T?, ErrorType?) -> () )) {
        

        URLSession.shared.dataTask(with: request) { (data, response, error) in


            if let error = error {
                completition(nil, .someError(error : error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else{
                completition(nil, .requestFailed(description : "Bad Http Request"))
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                completition(nil, .invalidStatusCode(statusCode : httpResponse.statusCode))
                return
            }
            
            guard let data = data  else {
                completition(nil, .invalidData)
                return
            }
            

            do {
                let results = try JSONDecoder().decode(T.self, from: data)
                completition(results, nil)
                
            }catch {
                completition(nil, .invalidJSONParse)
            }

        }.resume()

    }
}










/************************************************************************************************/
/************************************************************************************************/
/************************************************************************************************/
/************************************************************************************************/
/*
 Bu noktadan itibaren yazilan kodlar ornek amacli yazilmistir, test edilmesi zor ve generic kodlar olmadigi icin projede kullanilmamistir
 


class FetchService {

    
    
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
    
    
   
    
}*/



