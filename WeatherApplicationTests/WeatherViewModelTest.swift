//
//  WeatherViewModelTest.swift
//  WeatherApplicationTests
//
//  Created by Safa on 23.10.2023.
//

import XCTest
@testable import WeatherApplication
import Combine



class WeatherViewModelTest: XCTestCase {
    
    var viewModel : WeatherViewModel!
    var testWeather : [Weather]?
    private var cancellable : Set<AnyCancellable>!

    
    override func setUp() {
        super.setUp()
        //Mock nesnemiz ile normalde web uzerinden gelen veriyi taklit ediyoruz, bunu yaparken MockWeather.json dosyasini kullaniyoruz
        viewModel = WeatherViewModel(service: MockWebService())
        cancellable = []
    }
    

    override func tearDown() {
        super.tearDown()
        viewModel = nil
        cancellable = []
    }

    func testFetchDatasSuccessfully() throws {
    
        
        let expectation = XCTestExpectation(description: "fetching datas")
        
        //Verileri WeatherViewModel turunden objemizin fetchDatas() fonksiyonu ile cekiyoruz
        self.viewModel.fetchDatas(city: "AnyCity")
        
        viewModel.$testObject
            .sink { values in
                
                //Cities.json dosyasinda yer alan 2 adet verinin gelip gelmedigini kontrol ediyoruz 
                XCTAssertEqual(values?.count, 2)
                expectation.fulfill()
            }
            .store(in: &cancellable)
        
        //expectation ile verinin gelmesi icin bir zamanasimi koyuyoruz
        wait(for: [expectation], timeout: 2)

        
    }
    
    func testTrToEngSuccessfully() throws {
    

        //Fonksiyonumuzun Turkce karakterleri Ingilizce karakterlere basariyla cevirdigini kontrol ediyoruz
        XCTAssertEqual(self.viewModel.trToEng(string: "Gümüşhane"), "gumushane")
        
    }


}
