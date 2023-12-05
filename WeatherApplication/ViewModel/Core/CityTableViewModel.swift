//
//  CityTableViewModel.swift
//  WeatherApplication
//
//  Created by Safa on 3.09.2023.
//

import Foundation


struct CityTableViewModel {
    
    var cityList : [City]
    
    func numberOfRowSection() -> Int {
        return cityList.count
    }
    
    func cellForRowAt(index : Int) -> CityViewModel {
        let cell = self.cityList[index]
        return CityViewModel(city : cell)
    }
    
}


struct CityViewModel {
    
    var city : City
    
    var name : String {
        return city.name
    }
    
}
