//
//  WeatherViewModel.swift
//  WeatherApplication
//
//  Created by Safa on 1.09.2023.
//

import Foundation

class WeatherViewModel {
    
    var sharedService : Service
    
    init(service : Service) {
        self.sharedService = service
    }

}


//TableView icin kullanacagimiz ViewModel
struct WeatherTableViewModel {
    
    var weatherList : [Weather]
    
    func numberOfRowsInSection() -> Int {
        return weatherList.count
    }
    
    func cellForRowAt (index: Int) -> WeatherInfo {

        let weather = self.weatherList[index]
        return WeatherInfo(weather: weather)
    }
}
   

    struct WeatherInfo {
        
        let weather : Weather
        
        var status : String {
            return self.weather.status
        }
        var degree : String {
            return self.weather.degree
        }
        var min : String {
            return self.weather.min
        }
        var max : String {
            return self.weather.max
        }
        var night : String {
            return self.weather.night
        }
        var day : String {
            return self.weather.day
        }
        var humidity : String {
            return self.weather.humidity
        }
        var date : String {
            return self.weather.date
        }
        var description : String {
            return self.weather.description
        }
        var icon : String {
            return self.weather.icon
        }


    
    
}
