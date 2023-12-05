//
//  WeatherViewModel.swift
//  WeatherApplication
//
//  Created by Safa on 1.09.2023.
//

import Foundation

class WeatherViewModel : ObservableObject {
    
    var sharedService : Service
    @Published var weatherResult : WeatherResult?
    @Published var testObject : [Weather]?

    
    init(service : Service) {
        self.sharedService = service
    }

    
    func fetchDatas (city : String) {
        
        let city = trToEng(string: city)

        
        /*  Strong Reference Cycle durumundan kacinmak icin "weak self" ifadesini kullandik boylece Swift`e, WeatherViewController nesnesini closure icinde capture etme dedik aksi halde birbirini referans eden iki nesne oldugu icin ne closure ne de WeatherViewController nesnesi deallocate edilebilecek ve haliyle memory leak olusmasi kacinilmaz olacaktir
        */
        
        sharedService.getWeatherData(request : EndPoint.getWeathers(city: city).request() , type: WeatherJSON.self) { [weak self] (data, error) in
            
            if let error = error {
                self?.weatherResult = .failure(error)
            }else {
                if let data = data{
                    self?.weatherResult = .success(data.result)
                    self?.testObject = data.result
                }
            }
        }
        
    }
    

    func trToEng (string : String) -> String {
        let string = string.lowercased()
            .replacingOccurrences(of: "ı", with: "i")
            .replacingOccurrences(of: "ğ", with: "g")
            .replacingOccurrences(of: "ç", with: "c")
            .replacingOccurrences(of: "ş", with: "s")
            .replacingOccurrences(of: "ü", with: "u")
            .replacingOccurrences(of: "ö", with: "o")
        return string
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
