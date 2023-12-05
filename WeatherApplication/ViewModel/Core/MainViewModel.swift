//
//  MainViewModel.swift
//  WeatherApplication
//
//  Created by Safa on 5.12.2023.
//

import Foundation

class MainViewModel : ObservableObject {
    
    @Published var cityList : [City] = []

    func fetchFromJSON () {
            
        if let path = Bundle.main.path(forResource: "cities", ofType: "json"){
             
            guard let url = URL(fileURLWithPath: path) as? URL else {
                 print("DEBUG: URL error")
                return
            }
            
            guard let data = try? Data(contentsOf: url) else {
               print(ErrorType.invalidData.description)
                return
            }
            
            
             do {
                let jsonData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any]
                 
         
                if let cities = jsonData!["city"] as? [[String:String]] {
                        
                    for item in cities {
                         
                        if let name = item["name"] {
                            let city = City(name: name)
                            cityList.append(city)
                        }
                    }
                }

                }catch {
                    print(ErrorType.invalidJSONParse.description)
                }
             
         }
          
            
    }
    
    
    
    
}




