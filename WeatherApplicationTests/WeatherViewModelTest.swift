//
//  WeatherViewModelTest.swift
//  WeatherApplicationTests
//
//  Created by Safa on 23.10.2023.
//

import XCTest
@testable import WeatherApplication



class WeatherViewModelTest: XCTestCase {
    
    var viewModel : WeatherViewModel!
    var testWeather : [Weather]?

    
    override func setUp() {
        super.setUp()
        //Mock nesnemiz ile normalde web uzerinden gelen veriyi taklit ediyoruz, bunu yaparken MockWeather.json dosyasini kullaniyoruz
        viewModel = WeatherViewModel(service: MockWebService())
    }
    

    override func tearDown() {
        super.tearDown()
    }

    func testFetchDatasSuccessfully() throws {
    
        //Verileri WeatherViewModel turunden objemizin fetchDatas() fonksiyonu ile cekiyoruz
        self.viewModel.fetchDatas()
        
        switch viewModel.weatherResult {
            case .success (let weather):
                self.testWeather = weather
                break
            default:
                testWeather = []
        }
        
       
        //MockWeather.json dosyamizi okumamiz sonucunda, 2 adet veri donecegi icin bunu test ediyoruz
        XCTAssertEqual(self.testWeather?.count, 2)
        
    }
    
    func testTrToEngSuccessfully() throws {
    

        //Fonksiyonumuzun Turkce karakterleri Ingilizce karakterlere basariyla cevirdigini kontrol ediyoruz
        XCTAssertEqual(self.viewModel.trToEng(string: "Gümüşhane"), "gumushane")
        
    }


}
